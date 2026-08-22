cask "vpinball" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"

  version "10.8.1-5436-af26b2d93"
  sha256 arm:          "dabdd5b09be99d3dd02d2119aeead683317f862c97df556d4c5b1799292a7971",
         intel:        "5625e9c5a8529e6302eac135255faa9860b92d464c281fb6ed47c9b5b3fbfea5",
         x86_64_linux: "9d3f9793b0c8ebc3e53cea42e9963beeb5305a259f830d87cab9f1cda6c81a5d"

  on_macos do
    depends_on macos: :sonoma

    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinballX_BGFX.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPinballX_BGFX"
  end

  url "https://github.com/vpinball/vpinball/releases/download/v#{version}/VPinballX_BGFX-#{version}-#{os}-#{arch}-Release.#{ext}"
  name "VPinballX BGFX"
  desc "Visual Pinball BGFX"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url :url
    regex(/^v?(\d+\.\d+\.\d+-\d+-[0-9a-f]+)$/)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
