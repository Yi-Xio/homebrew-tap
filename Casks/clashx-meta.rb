# 参考： https://github.com/zuisong/homebrew-tap/blob/main/Casks/clashx-meta.rb
# Clash.meta 项目：https://github.com/MetaCubeX/ClashX.Meta

cask "clashx-meta" do
    version "1.4.8"
    sha256 "216ab727e2f60c533a933c22e21e677132974683660a71907f3332c447a27e80"
  
    url "https://github.com/MetaCubeX/ClashX.Meta/releases/download/v#{version}/ClashX.Meta.zip"
    name "ClashX Meta"
    desc "Rule-based custom proxy with GUI based on Clash.Meta"
    homepage "https://github.com/MetaCubeX/ClashX.Meta"
  
    livecheck do
      url :url
      strategy :github_latest
    end
  
    app "ClashX Meta.app"

    # 仅做安装和卸载工具，更新交给软件自己处理
    auto_updates true
    conflicts_with cask: "clashx-meta"
  
    uninstall launchctl: "com.metacubex.ClashX.ProxyConfigHelper",
              quit:      "com.metacubex.ClashX",
              delete:    [
                "/Library/LaunchDaemons/com.metacubex.ClashX.ProxyConfigHelper.plist",
                "/Library/PrivilegedHelperTools/com.metacubex.ClashX.ProxyConfigHelper",
                "~/Library/Application Support/com.metacubex.ClashX.meta",
                "~/Library/Caches/com.metacubex.ClashX.meta",
                "~/Library/Logs/ClashX Meta",
                "~/Library/Preferences/com.metacubex.ClashX.meta.plist",
              ]
  
  end
  