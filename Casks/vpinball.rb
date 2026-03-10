cask "vpinball" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "10.8.1-3582-b9fc92d"
  sha256 arm:          "a5ae694342b16d0afdcc3c0cb1eec06046ca655b439e5ddbdf42dcbf3e7d964a",
         intel:        "2ae19871b0c8b8bdb1f1a1e49349fbb3a470d454de4b26257e274588bb262f8b",
         x86_64_linux: "0622e6e7f04f081735027c510a5263815026212816e3fd1cf7e8166b25933a29"

  url "https://github.com/vpinball/vpinball/releases/download/v#{version}/VPinballX_BGFX-#{version}-#{os}-#{arch}-Release.zip"
  name "VPinballX BGFX"
  desc "Visual Pinball BGFX"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url :url
    regex(/^v?(\d+\.\d+\.\d+-\d+-[0-9a-f]{7})$/)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :sonoma"

  on_macos do
    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"
  end

  on_linux do
    binary "VPinballX_BGFX"
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
