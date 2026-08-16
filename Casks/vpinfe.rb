cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.6.1"
  sha256 arm:          "c89fbd75732683aeea28701819df95cd3cd7aca447f15c9a6a10052df30d705f",
         arm64_linux:  "edee91733c70ceebb1c36b0ece90c3c0d734c5b8ae3f349b9c9ffb39f52e5270",
         x86_64_linux: "2a807aab08e9e3e02365a0869efc162878be402c7c156fbaef90a5fbfa76b397"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    app "VPinFE.app"
    binary "#{appdir}/VPinFE.app/Contents/MacOS/VPinFE", target: "vpinfe"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinFE.app"]
    end
  end
  on_linux do
    binary "vpinfe/vpinfe"
  end

  url "https://github.com/superhac/vpinfe/releases/download/v#{version}/vpinfe-v#{version}-#{os}-#{arch}.zip"
  name "VPinFE"
  desc "A vpinball frontend for Linux, Mac, and Windows"
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

  zap trash: [
    "~/.config/vpinfe",
    "~/Library/Application Support/vpinfe",
  ]
end
