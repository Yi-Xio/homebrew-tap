# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
  version "2.1.2"
  sha256 "97215c113acf737151cb5dd15ed7badea50b7c269eaac427e6ff42388ef6e794"

  url "https://github.com/X1a0He/Adobe-Downloader/releases/download/#{version}/Adobe.Downloader.dmg"
  name "Adobe Downloader"
  desc "GUI tool for downloading and installing Adobe apps"
  homepage "https://github.com/X1a0He/Adobe-Downloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Adobe Downloader.app"

  auto_updates true

  uninstall launchctl: "com.x1a0he.macOS.Adobe-Downloader",
            quit:      "com.x1a0he.macOS.Adobe-Downloader",
            script:    {
              executable: "/bin/sh",
              args: ["-c", "pkill 'Adobe Downloader' || true"]
            },
            delete: [
              "/Library/LaunchDaemons/com.x1a0he.macOS.Adobe-Downloader.helper.plist",
              "/Library/PrivilegedHelperTools/com.x1a0he.macOS.Adobe-Downloader.helper"
            ]

  zap trash: [
    "/Applications/Adobe Downloader.app",
    "~/Library/Application Support/Adobe Downloader",
    "~/Library/Preferences/com.x1a0he.macOS.Adobe-Downloader.plist",
    "~/Library/Caches/com.x1a0he.macOS.Adobe-Downloader",
    "~/Library/HTTPStorages/com.x1a0he.macOS.Adobe-Downloader",
    "~/Library/HTTPStorages/com.x1a0he.macOS.Adobe-Downloader.binarycookies",
  ]
end