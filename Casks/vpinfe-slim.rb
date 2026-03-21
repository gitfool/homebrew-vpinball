cask "vpinfe-slim" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "1.1.16"
  sha256 arm:          "9f787c7c2d02370c1155f012fc9fa1774e716f426065a01a9b732cc2894c758b",
         arm64_linux:  "5d60a6fa42d4f25fb007100f0e6b9d6c486ece112c4dfb70d087520af358120a",
         x86_64_linux: "48fdb6febd163fe527040dae09fb74acfddd11ebc9bad991a7b7ec4cd2129bb2"

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
