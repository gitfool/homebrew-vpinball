cask "vpinfe-slim" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "1.1.70"
  sha256 arm:          "54ae805e254d0c64b4e061a5ad53a4ce4ed68a18d04453f5618787bbc94fbf2a",
         arm64_linux:  "4e0feed0f044b346604d916beba173df4b3620d035e0f9c6f218432361d86ff8",
         x86_64_linux: "c5b034542fcb7a985ea24b85e55e98b30cae6f4732afa99fb049888c97e117e3"

  url "https://github.com/superhac/vpinfe/releases/download/v#{version}/vpinfe-v#{version}-#{os}-#{arch}-slim.zip"
  name "VPinFE (slim)"
  desc "A vpinball frontend for Linux, Mac, and Windows (slim)"
  homepage "https://github.com/superhac/vpinfe"

  livecheck do
    url :url
    regex(/^v?(\d+\.\d+\.\d+)$/)
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
    app "VPinFE.app"
    binary "#{appdir}/VPinFE.app/Contents/MacOS/VPinFE", target: "vpinfe"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinFE.app"]
    end
  end

  on_linux do
    binary "vpinfe/vpinfe"
  end

  zap trash: [
    "~/.config/vpinfe",
    "~/Library/Application Support/vpinfe",
  ]
end
