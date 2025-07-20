# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
  version "2.1.0"
  sha256 "e770b14fb636aef555bf832d0a81dc7c3ac38f4cf9b06f96d1fff5b5b8900c27"

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