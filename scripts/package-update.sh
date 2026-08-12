#!/usr/bin/env bash
set -euo pipefail

verified=${VELNOR_VERIFIED_PACKAGE_DIR:?missing VELNOR_VERIFIED_PACKAGE_DIR}
manifest="$verified/release-manifest.json"
identity="$verified/identity.json"

jq -e '
  keys == ["manifest","source_digest","source_ref","source_repository"] and
  .source_repository == "tailrocks/tablerock" and
  (.source_ref | test("^refs/tags/v[0-9]+[.][0-9]+[.][0-9]+$")) and
  (.source_digest | test("^[0-9a-f]{40}$"))
' "$identity" >/dev/null

version=$(jq -er '.version | select(test("^[0-9]+[.][0-9]+[.][0-9]+$"))' "$manifest")
tag="v$version"
jq -e --arg ref "refs/tags/$tag" '
  keys == ["assets","schema","source_commit","source_ref","source_repository","version"] and
  .schema == "velnor.package-release.v1" and
  .source_repository == "tailrocks/tablerock" and
  .source_ref == $ref and
  (.source_commit | test("^[0-9a-f]{40}$")) and
  ([.assets[].name] | length) == 5 and
  ([.assets[].name] | unique | length) == 5
' "$manifest" >/dev/null

asset() {
  local name=$1
  test -f "$verified/$name"
  jq -er --arg name "$name" '
    [.assets[] | select(.name == $name)]
    | select(length == 1)
    | .[0].sha256
    | select(test("^[0-9a-f]{64}$"))
  ' "$manifest"
}

mac_arm=$(asset "tablerock-${version}-aarch64-apple-darwin.tar.gz")
mac_intel=$(asset "tablerock-${version}-x86_64-apple-darwin.tar.gz")
linux_arm=$(asset "tablerock-${version}-aarch64-unknown-linux-gnu.tar.gz")
linux_intel=$(asset "tablerock-${version}-x86_64-unknown-linux-gnu.tar.gz")
app_arm=$(asset "tablerock-app-${version}-aarch64-apple-darwin.zip")
source_commit=$(jq -er '.source_commit' "$manifest")
test "$(jq -r '.source_digest' "$identity")" = "$source_commit"

cat > Formula/tablerock.rb <<EOF
# source-sha: $source_commit
class Tablerock < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "$version"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/$tag/tablerock-$version-aarch64-apple-darwin.tar.gz"
      sha256 "$mac_arm"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/$tag/tablerock-$version-x86_64-apple-darwin.tar.gz"
      sha256 "$mac_intel"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/$tag/tablerock-$version-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "$linux_arm"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/$tag/tablerock-$version-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "$linux_intel"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
EOF

cat > Casks/tablerock-app.rb <<EOF
# source-sha: $source_commit
cask "tablerock-app" do
  version "$version"
  sha256 "$app_arm"

  url "https://github.com/tailrocks/tablerock/releases/download/$tag/tablerock-app-$version-aarch64-apple-darwin.zip"
  name "TableRock"
  desc "Native PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "TableRock.app"

  zap trash: "~/Library/Application Support/TableRock"
end
EOF
