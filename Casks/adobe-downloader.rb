# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
  version "2.1.3"
  sha256 "f37ca913c147e8e9f85df63281dd6eb4f42a2c007a35d85a37e53c2ade8691d2"

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