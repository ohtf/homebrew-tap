class PanicButtonRelay < Formula
  desc "Panic Button relay: a blind, multi-tenant forwarder of sealed envelopes."
  homepage "https://github.com/ohtf/panic-button#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-relay-aarch64-apple-darwin.tar.xz"
      sha256 "0af28f6b53357c2743095860d36e1d00eb666a7031ea640f189f2a7a7a101646"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-relay-x86_64-apple-darwin.tar.xz"
      sha256 "3ec42b1c5128896497edf5bdcc4feb678c1a322ead32f213af56bf111a1d4f33"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-relay-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "af64e0451974918314a245b845091871cca0b5bbe83b482f56cd8c624884aa2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-relay-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "556b315fa5898167d5c6ef8ce7b355779e8bb0a383acb8591d001df978897eee"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "panic-button-relay"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "panic-button-relay"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "panic-button-relay"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "panic-button-relay"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
