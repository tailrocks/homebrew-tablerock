# source-sha: e2ccfceb79de926ecfbfe6e1df906b535332b663
cask "tablerock-app@preview" do
  version "0.1.0-preview.763,e2ccfce"
  sha256 "8e5a00af5105dd081a5c4aa7c95e1d65c86c0d736fb5d1b36211c7f0e2ee06cb"

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
