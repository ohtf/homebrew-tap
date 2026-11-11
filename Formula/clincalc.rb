class Clincalc < Formula
  desc "Open, auditable clinical calculators: a serde-only scoring engine plus the `clincalc` CLI and loopback REST API in one crate."
  homepage "https://github.com/ohtf/clincalc"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/clincalc/releases/download/v0.5.0/clincalc-aarch64-apple-darwin.tar.xz"
      sha256 "cbd322300c948ae2b75474f8673e10794fc5bcfe37bd0ac887b650ffa63fbec3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/clincalc/releases/download/v0.5.0/clincalc-x86_64-apple-darwin.tar.xz"
      sha256 "d28a53610a992860e0a4e0af3f8aee4bb7e60fe208363e26a71da464d7de8d15"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ohtf/clincalc/releases/download/v0.5.0/clincalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0c5aaa905f16c1d894cfe2b0c39c32c25d3284f5c2060df6fbb7e1478d3471f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ohtf/clincalc/releases/download/v0.5.0/clincalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7dc484927d5640af39e0f7aea43c4960eaa029e39116df3e3fe321d3491e192"
    end
  end
  license all_of: ["AGPL-3.0-or-later", "LGPL-3.0-or-later"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "clincalc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "clincalc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "clincalc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "clincalc"
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
