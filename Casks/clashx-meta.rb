# 参考： https://github.com/zuisong/homebrew-tap/blob/main/Casks/clashx-meta.rb
# Clash.meta 项目：https://github.com/MetaCubeX/ClashX.Meta

cask "clashx-meta" do
    version "1.4.11"
    sha256 "1d19e60a35fb0b06ce95afd135fb454d9c33807537e75495f5e821cb2e0299ff"
  
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
  