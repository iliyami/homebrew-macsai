cask "mac-sai" do
  version "1.9.0"
  # Set to the published DMG's hash at release time. build-dmg.sh prints
  # "SHA256:" at the end; the release workflow fills this in automatically.
  sha256 "6c7c6d600caf666c8de795f5e5e881a18f110f051bb04e29b452b070f6483d9d"

  url "https://github.com/iliyami/MacSai/releases/download/v#{version}/MacSai-#{version}.dmg",
      verified: "github.com/iliyami/MacSai/"
  name "Mac Sai"
  desc "Open-source Mac cleaner, optimizer, and malware scanner"
  homepage "https://github.com/iliyami/MacSai"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Mac Sai.app"

  zap trash: [
    "~/Library/Application Support/MacClean",
    "~/Library/Caches/com.macclean.app",
    "~/Library/Logs/MacClean",
    "~/Library/Preferences/com.macclean.app.plist",
    "~/Library/Saved Application State/com.macclean.app.savedState",
  ]

  caveats <<~EOS
    Some features (Mail, Safari, Privacy scans) require Full Disk Access:
      System Settings → Privacy & Security → Full Disk Access
  EOS
end
