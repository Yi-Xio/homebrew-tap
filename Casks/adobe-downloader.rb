# Adobe Downloader 项目：https://github.com/X1a0He/Adobe-Downloader

cask "adobe-downloader" do
  version "3.1.0"
  sha256 "5a402946fc2aee56d9d8dc7eb3d038e8521ee75de8e5af4c8c2edcf02ea79843"

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
