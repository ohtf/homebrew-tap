#
cask "panic-button" do
  version "0.1.0"
  sha256 "119a2850a73444830eb86c090d5bba65d37bba19be7388c41bdc122ef7f75de3"

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
