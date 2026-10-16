# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
  version "3.2.0"
  sha256 "3857bcb7a79830111878fc645bffc381af890e492446ece0473d35379ce694e1"

  url "https://github.com/X1a0He/Adobe-Downloader/releases/download/#{version}/Adobe.Downloader.dmg"
  name "Adobe Downloader"
  desc "GUI tool for downloading and installing Adobe apps"
  homepage "https://github.com/X1a0He/Adobe-Downloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Adobe Downloader.app"

  uninstall launchctl: "com.x1a0he.macOS.Adobe-Downloader",
            quit:      "com.x1a0he.macOS.Adobe-Downloader",
            delete:    [
              "/Library/LaunchDaemons/com.x1a0he.macOS.Adobe-Downloader.helper.plist",
              "/Library/PrivilegedHelperTools/com.x1a0he.macOS.Adobe-Downloader.helper",
            ]

  zap trash: [
    "~/Library/Application Support/Adobe Downloader",
    "~/Library/Caches/com.x1a0he.macOS.Adobe-Downloader",
    "~/Library/HTTPStorages/com.x1a0he.macOS.Adobe-Downloader",
    "~/Library/HTTPStorages/com.x1a0he.macOS.Adobe-Downloader.binarycookies",
    "~/Library/Preferences/com.x1a0he.macOS.Adobe-Downloader.plist",
  ]
end
