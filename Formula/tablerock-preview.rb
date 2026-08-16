# source-sha: 39f2b8621f482706e0b1089f4ac033de5aea2099
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.863+39f2b86"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "907ae4082e27cbe67caaaaba0024761ca23d7473f0272d72c6567cb6bdde1c37"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "4768d2b7fd223dd7e0a747ce5b3d1c9d670ae426fa614bed6475813e3732d975"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7534e7e6fb08ba3ab96bfc30ecb4c66a234d4192f3519c38fc84fc0b37ac0931"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed59b4f719c29fea24a9d7d1154bb208262c2191057338c5831c144441ca22ab"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
