# source-sha: 2c100eb07970ba6b0cfc5351b757e338dfd09a92
cask "tablerock-app@preview" do
  version "0.1.0-preview.865,2c100eb"
  sha256 "10ad20738ed1779d0d825f4f4afc4d787c31f5ed6f02418b55f40a231694809c"

  url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-app-aarch64-apple-darwin.zip"
  name "TableRock Preview"
  desc "Native PostgreSQL, ClickHouse, and Redis workbench preview"
  homepage "https://github.com/tailrocks/tablerock"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "TableRock.app"

  caveats <<~EOS
    This preview is ad-hoc signed and not notarized.
    On first launch, right-click TableRock and choose Open, or run:
      xattr -dr com.apple.quarantine /Applications/TableRock.app
  EOS

  zap trash: "~/Library/Application Support/TableRock"
end
