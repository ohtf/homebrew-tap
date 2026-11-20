class PanicButtonCli < Formula
  desc "A staff panic alarm over the local network: the panic-button admin CLI, the headless panic-button-agent and the panic-button-relay server."
  homepage "https://github.com/ohtf/panic-button#readme"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.1/panic-button-aarch64-apple-darwin.tar.xz"
      sha256 "0506ef0e2f8e97142ad5ec94abfe73ea07eee413349736c8dba7ffdd07b397c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.1/panic-button-x86_64-apple-darwin.tar.xz"
      sha256 "50c269d94909bed5c907e04d97ff5368af874874377ce317c20466195a56a1a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.1/panic-button-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "14f44a5ac5ad85cb689f337c7b8ae6084fb550e8eaa72e43e6b5ea166448775f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.1/panic-button-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c4671f8486b64f3ef65999473e78fd98c5c9ba955c5e84c6065349238c46f2ff"
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
      bin.install "panic-button", "panic-button-agent", "panic-button-relay"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "panic-button", "panic-button-agent", "panic-button-relay"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "panic-button", "panic-button-agent", "panic-button-relay"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "panic-button", "panic-button-agent", "panic-button-relay"
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
