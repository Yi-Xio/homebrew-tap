#!/usr/bin/env bash
#
# 检查 tap 内各 cask 的上游版本，对过期者调用 brew bump-cask-pr 写入更新并生成提交。
# 由 .github/workflows/update-brew.yml 调用，推送动作留给调用方。
# 任一 cask 检查或更新失败时继续处理其余 cask，汇总后返回非零状态。
#
# 必须在 tap 仓库根目录运行，因为 bump-cask-pr 要求 cask 位于一个 tap 内。
#
# 环境变量：
#   TAP_NAME  tap 名称，形如 user/repo，必需
#
# 本脚本只处理版本变化。版本未变但需要重算 sha256 时手动执行：
#   brew fetch --cask <tap>/<cask>
#     校验通过打印勾号，不通过则同时列出记录值与实际值
#   brew bump-cask-pr --write-only --commit \
#     --version <当前版本> --sha256 <实际值> <tap>/<cask>
#     版本号保持不变，仅改写 sha256 并生成提交

set -euo pipefail

tap_name="${TAP_NAME:?TAP_NAME is required, e.g. yi-xio/tap}"

# 目录不存在时让通配符展开为空，而非留下字面量
shopt -s nullglob

updated=0
skipped=0
failed=0

for cask_file in Casks/*.rb; do
  cask_name="$(basename "${cask_file}" .rb)"
  full_name="${tap_name}/${cask_name}"

  echo "==> Checking ${cask_name}"

  if ! livecheck_json="$(brew livecheck --cask "${full_name}" --json)"; then
    echo "    livecheck failed for ${cask_name}" >&2
    # livecheck 的错误原因也可能只出现在标准输出的 JSON 中。
    if [[ -n "${livecheck_json}" ]]; then
      printf '%s\n' "${livecheck_json}" >&2
    fi
    failed=$((failed + 1))
    continue
  fi

  if ! livecheck_status="$(jq -r '.[0].status // empty' <<<"${livecheck_json}")"; then
    echo "    invalid livecheck response for ${cask_name}" >&2
    failed=$((failed + 1))
    continue
  fi

  # livecheck 明确跳过检查的状态不计为失败。
  case "${livecheck_status}" in
    skipped|disabled|deprecated|latest|unversioned)
      reason="$(jq -r '.[0].messages // [] | join("; ")' <<<"${livecheck_json}")"
      echo "    ${livecheck_status}${reason:+: ${reason}}"
      skipped=$((skipped + 1))
      continue
      ;;
  esac

  latest="$(jq -r '.[0].version.latest // empty' <<<"${livecheck_json}")"
  current="$(jq -r '.[0].version.current // empty' <<<"${livecheck_json}")"
  outdated="$(jq -r '.[0].version.outdated // false' <<<"${livecheck_json}")"

  # livecheck 失败时返回的是 status/messages 而非 version
  if [[ -z "${latest}" || -z "${current}" ]]; then
    reason="$(jq -r '.[0].messages // ["missing version information"] | join("; ")' <<<"${livecheck_json}")"
    echo "    unable to determine versions for ${cask_name}: ${reason}" >&2
    failed=$((failed + 1))
    continue
  fi

  echo "    current=${current} latest=${latest} outdated=${outdated}"

  if [[ "${outdated}" != "true" ]]; then
    echo "    up-to-date"
    continue
  fi

  # bump-cask-pr 负责下载、计算 sha256 并改写公式，多架构公式由其原生处理
  echo "    bumping to ${latest}"
  head_before="$(git rev-parse HEAD)"
  if brew bump-cask-pr --write-only --commit --version "${latest}" "${full_name}"; then
    # bump-cask-pr 的提交消息固定为 "<cask> <version>"，改写为带说明的形式。
    # 比对 HEAD 以确认提交确实产生，避免空转时误改上一条提交
    if [[ "$(git rev-parse HEAD)" != "${head_before}" ]]; then
      git commit --amend --quiet --message "Update ${cask_name} from ${current} to ${latest}"
    fi
    updated=$((updated + 1))
  else
    echo "    bump failed for ${cask_name}" >&2
    failed=$((failed + 1))
  fi
done

echo "==> Done: ${updated} updated, ${skipped} skipped, ${failed} failed"

if [[ "${failed}" -gt 0 ]]; then
  exit 1
fi
