# source-sha: 942b1a9e42864b86fe9a98c5c86db815a0343991
cask "tablerock-app@preview" do
  version "0.1.0-preview.794,942b1a9"
  sha256 "956e4530c479f6997d0e2762404b9011eda454351d6fa4c1cb4b8b727c605c56"

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
