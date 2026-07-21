# source-sha: 349a6f4c42f6f6fad9ba9707e64d57c71c37b69d
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.633+349a6f4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "aedb26ead3ad0a2c8f34aa2fbecb4ffe813a22069ff5c089ecd64e3f430d9429"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "64fb2bc9d6d87e838068afd6fd34d62c3f76f8f0173bfe2a28158fe21c3b67e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "327cc2361b17dad00d06e9c158e1bd20ce407d7020eeece184ef689642be71f6"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb89650f0abcac72da7a29a0adbdf5d8cd1922cf2cdd0bfd3f26c46f020e44b3"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
