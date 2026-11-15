class PanicButtonAgent < Formula
  desc "Panic Button agent runtime: wires core, network, store and platform; control API."
  homepage "https://github.com/ohtf/panic-button#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-agent-aarch64-apple-darwin.tar.xz"
      sha256 "67f7aab4333c1fe2eb60107ec8f406c0ee78f7bd2d0137c6fe92c30479569f1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-agent-x86_64-apple-darwin.tar.xz"
      sha256 "118f72f49f3b2e7a3fcc52a22d9750bb242c394343a158ec3bb8b8fa8e3883f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-agent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1bdced08b156a5f1d14e66d485cff6fba9baafa29d182d44898428d3aba3cccd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.1.0/panic-button-agent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "598728da34233bac3d5461674b26a14af4664cb05b1fff1c84596ddf4e39e055"
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
      bin.install "panic-button-agent"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "panic-button-agent"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "panic-button-agent"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "panic-button-agent"
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
