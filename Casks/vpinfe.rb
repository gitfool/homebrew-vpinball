cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "1.1.26"
  sha256 arm:          "c28c8446ac08ce081aaba6eec668a2c21431c97e3be2fa8d0df112aadf3c5b4a",
         arm64_linux:  "cb85e4b1c3848930a32380906829b24289c3c453ecfa13b738de9ba1f6189652",
         x86_64_linux: "de06826ca57f992344cb0ea574e51d9c6d123deb96d2ead2023f83055fbfdb3d"

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
