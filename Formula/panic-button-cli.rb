class PanicButtonCli < Formula
  desc "The panic-button admin and diagnostics command-line tool."
  homepage "https://github.com/ohtf/panic-button#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-aarch64-apple-darwin.tar.xz"
      sha256 "3da3cd33072ec0b34a1d6db07a77af39a42490297f5e9e7c455a17114b7a851c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-x86_64-apple-darwin.tar.xz"
      sha256 "a0cbce8d6c4a345610601057983e99b24355309c43fe0eecc0dd4819de18b411"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cc1e4a991c46da8b7850fd82c641977d0bc7a1712626a26f34ce983842cd3b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "06da009c0e5604df521c783169711349bedb32d3c45cf6b57482af38bfe726a1"
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
      bin.install "panic-button"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "panic-button"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "panic-button"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "panic-button"
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
