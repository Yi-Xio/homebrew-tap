# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
    version "1.3.1"
    sha256 "a114fa39d8390c9bc48acb253637b94e7f1a57b17e53301a3c9be50a8c1f50c5"
  
    url "https://github.com/X1a0He/Adobe-Downloader/releases/download/#{version}/Adobe.Downloader.dmg"
    name "Adobe Downloader"
    desc "Rule-based custom proxy with GUI based on Clash.Meta"
    homepage "https://github.com/X1a0He/Adobe-Downloader"
    
    auto_updates true
    conflicts_with cask: "adobe-downloader"
  
    livecheck do
      url :url
      strategy :github_latest
    end
  
    app "Adobe Downloader.app"
  
    uninstall launchctl: "com.x1a0he.macOS.Adobe-Downloader",
              quit:      "com.x1a0he.macOS.Adobe-Downloader",
              delete:    [
                "/Library/LaunchDaemons/com.x1a0he.macOS.Adobe-Downloader.helper.plist",
                "/Library/PrivilegedHelperTools/com.x1a0he.macOS.Adobe-Downloader.helper",
              ]
  
  end
  