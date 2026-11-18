class PanicButtonCli < Formula
  desc "A staff panic alarm over the local network: the panic-button admin CLI, the headless panic-button-agent and the panic-button-relay server."
  homepage "https://github.com/ohtf/panic-button#readme"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.0/panic-button-aarch64-apple-darwin.tar.xz"
      sha256 "616a304077bde3b4e30ec13c73ff389aedd8921ab5b1e5e3c45f7f0a2ce45973"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.0/panic-button-x86_64-apple-darwin.tar.xz"
      sha256 "ae34ad5a3a4e7a4bd612b4ce7e984b866f1f688a9dcfc3f736c8814445b0d631"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.0/panic-button-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c6529a918fd93fc1cd4086d5d5189432f1cbe93433fc54d7414ba67094fd08c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/panic-button/releases/download/v0.2.0/panic-button-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd4b8c92aa199eed0808122ee1f3afc026abde52decfd03a7158bb5c2221d7d3"
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
