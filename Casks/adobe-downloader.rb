# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
    version "2.0.1"
    sha256 "bbdb0d42f130a3e2a41a9d5f2a31901dc32498b3f75831e3d73e10bb39432e72"
  
    url "https://github.com/X1a0He/Adobe-Downloader/releases/download/#{version}/Adobe.Downloader.dmg"
    name "Adobe Downloader"
    desc "Rule-based custom proxy with GUI based on Clash.Meta"
    homepage "https://github.com/X1a0He/Adobe-Downloader"
  
    livecheck do
      url :url
      strategy :github_latest
    end
  
    app "Adobe Downloader.app"

    # 仅做安装和卸载工具，更新交给软件自己处理
    auto_updates true
    conflicts_with cask: "adobe-downloader"
    
    uninstall launchctl: "com.x1a0he.macOS.Adobe-Downloader",
              quit:      "com.x1a0he.macOS.Adobe-Downloader",
              script:    {
                executable: "/bin/sh",
                args: ["-c", "pkill 'Adobe Downloader'"]
              },
              delete: [
                "/Library/LaunchDaemons/com.x1a0he.macOS.Adobe-Downloader.helper.plist",
                "/Library/PrivilegedHelperTools/com.x1a0he.macOS.Adobe-Downloader.helper",
              ]
  
  end
  