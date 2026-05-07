cask "vpinfe-slim" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.2.4"
  sha256 arm:          "976c19f61f61566a69ba67e473555b0cdac2e5f4525390af3d74320368a2d07a",
         arm64_linux:  "0b428f15e22ca43018a164695097bfade7d7f64a44f5789747a41016688af9da",
         x86_64_linux: "83d046d9cc766d4c7a25e71e12b48f87e11de4c8cf691e56cf80075368d02d44"

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
