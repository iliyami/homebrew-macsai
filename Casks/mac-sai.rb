cask "mac-sai" do
  version "1.24.0"
  # Set to the published DMG's hash at release time. build-dmg.sh prints
  # "SHA256:" at the end; the release workflow fills this in automatically.
  sha256 "03ea2b0722ce2ad2f0eb81f53a153a0c0c6498ee2bb2ab86c5ec02172686ebfa"

  # Homebrew dropped the optional URL hostname check (Homebrew/brew#23280);
  # keeping it only produced a brew-update warning (issue #147). url and
  # homepage already share github.com/iliyami/MacSai.
  url "https://github.com/iliyami/MacSai/releases/download/v#{version}/MacSai-#{version}.dmg"
  name "Mac Sai"
  desc "Open-source Mac cleaner, optimizer, and malware scanner"
  homepage "https://github.com/iliyami/MacSai"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Symbol form means "this release or newer"; the old comparison-string
  # form (">= :sonoma") is deprecated by Homebrew and warns on every install.
  depends_on macos: :sonoma

  app "Mac Sai.app"

  # Quit a running Mac Sai before upgrading/uninstalling so the old copy is
  # cleanly replaced instead of lingering (macOS can't swap a running app).
  uninstall quit: "com.macclean.app"

  zap trash: [
    "~/Library/Application Support/MacClean",
    "~/Library/Caches/com.macclean.app",
    "~/Library/HTTPStorages/com.macclean.app",
    "~/Library/Logs/MacClean",
    "~/Library/Preferences/com.macclean.app.plist",
    "~/Library/Preferences/com.macclean.shared.plist",
    "~/Library/Saved Application State/com.macclean.app.savedState",
  ]

  caveats <<~EOS
    Some features (Mail, Safari, Privacy scans) require Full Disk Access:
      System Settings → Privacy & Security → Full Disk Access
  EOS
end
