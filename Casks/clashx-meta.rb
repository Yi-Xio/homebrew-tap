# 参考： https://github.com/zuisong/homebrew-tap/blob/main/Casks/clashx-meta.rb
# Clash.meta 项目：https://github.com/MetaCubeX/ClashX.Meta

cask "clashx-meta" do
    version "1.4.26"
    sha256 "642314ef5481bf4806bd60f94074d07985090566369be3a96fd42271f169270c"
  
    url "https://github.com/MetaCubeX/ClashX.Meta/releases/download/v#{version}/ClashX.Meta.zip"
    name "ClashX Meta"
    desc "Rule-based custom proxy with GUI based on Clash.Meta"
    homepage "https://github.com/MetaCubeX/ClashX.Meta"
  
    livecheck do
      url :url
      strategy :github_latest
    end
  
    app "ClashX Meta.app"

    auto_updates true
  
    uninstall launchctl: "com.metacubex.ClashX.ProxyConfigHelper",
            quit:      "com.metacubex.ClashX",
            delete:    [
              "/Library/LaunchDaemons/com.metacubex.ClashX.ProxyConfigHelper.plist",
              "/Library/PrivilegedHelperTools/com.metacubex.ClashX.ProxyConfigHelper"
            ]

  zap trash: [
    "~/Library/Application Support/com.metacubex.ClashX.meta",
    "~/Library/Caches/com.metacubex.ClashX.meta",
    "~/Library/Logs/ClashX Meta",
    "~/Library/Preferences/com.metacubex.ClashX.meta.plist"
  ]
  
  end
  