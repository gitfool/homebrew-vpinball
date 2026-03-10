cask "vpinball" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "10.8.1-3788-2151290"
  sha256 arm:          "61557f85f94a8093c5add2c66f8d6978786666bb7e77b26866abe1cec406f303",
         intel:        "3bcc61cfd4c73423de7aa641023c75bd4db0b34f2a67dc4617315c49066a762b",
         x86_64_linux: "4b08c536b668dd15ed096528d882d8af39c1fe8c10023e23f87d6c9e4f596cd7"

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

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinballX_BGFX.app"]
    end
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
