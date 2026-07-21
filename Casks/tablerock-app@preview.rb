# source-sha: 9e321389829e9b5f8dee52dac9e6d01bd8dba490
cask "tablerock-app@preview" do
  version "0.1.0-preview.623,9e32138"
  sha256 "61c7d1f69037a4ed2bdb2e9ba4c02db0690eb14a76f2534a02ac7ae0085c2b3a"

  url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-app-aarch64-apple-darwin.zip"
  name "TableRock Preview"
  desc "Native PostgreSQL, ClickHouse, and Redis workbench preview"
  homepage "https://github.com/tailrocks/tablerock"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "TableRock.app"

  caveats <<~EOS
    This preview is ad-hoc signed and not notarized.
    On first launch, right-click TableRock and choose Open, or run:
      xattr -dr com.apple.quarantine /Applications/TableRock.app
  EOS

  zap trash: "~/Library/Application Support/TableRock"
end
