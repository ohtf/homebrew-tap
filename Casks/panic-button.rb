cask "panic-button" do
  version "0.2.0"
  sha256 "41ef663f584c565a57c8735afee8e675862e409a996e25994c500ede039547ae"

  url "https://github.com/ohtf/panic-button/releases/download/v#{version}/panic-button-desktop_#{version}_universal.dmg"
  name "Panic Button"
  desc "Staff panic alarm: call colleagues for help from this computer"
  homepage "https://github.com/ohtf/panic-button"

  depends_on macos: ">= :monterey"

  app "Panic Button.app"

  zap trash: [
    "~/Library/Application Support/org.ohtf.panic-button",
    "~/Library/Caches/org.ohtf.panic-button",
    "~/.local/share/panic-button",
  ]

  caveats <<~EOS
    Panic Button is not yet signed by Apple. If macOS says it cannot be
    opened, run:
      xattr -dr com.apple.quarantine "/Applications/Panic Button.app"
  EOS
end
