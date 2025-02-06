# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
    version "1.5.1"
    sha256 "c2f5b8dc052985edb283a60ae2143454761c0896b489899937440785df4851db"
  
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
  