cask "panic-button" do
  version "0.2.1"
  sha256 "de07789a295418d473a6af1872c3fe59a8fdc3c7837d5bff64be69f4d6bc34e8"

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
