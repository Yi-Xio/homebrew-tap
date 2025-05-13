# 参考： https://github.com/zuisong/homebrew-tap/blob/main/Casks/clashx-meta.rb
# Clash.meta 项目：https://github.com/MetaCubeX/ClashX.Meta

cask "clashx-meta" do
    version "1.4.16"
    sha256 "bb7d75be263b3888562ea74ae159da3c668deca2e80c80b1e9943bf70cedc398"
  
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
  