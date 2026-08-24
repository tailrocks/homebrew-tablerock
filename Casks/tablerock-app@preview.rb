# source-sha: a37344a9a2366c0e563613c25325e0b357803e8a
cask "tablerock-app@preview" do
  version "0.1.0-preview.867,a37344a"
  sha256 "b35e8c11f4066008c9cc23f71aacd87aaa0572fa0247858dc9d134f1f4c96b2d"

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
