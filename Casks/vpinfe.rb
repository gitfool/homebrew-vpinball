cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.6.0"
  sha256 arm:          "a91c00b1f4fd3a6771250136f8996ebb850f5552f1d5935a3c09d64209c49ed3",
         arm64_linux:  "9591ebfb6679b5b98ccc99b329afa52836aa65d38d219bb22998d2ea5166433c",
         x86_64_linux: "470c7dcf8740b7f5eaeaf06edd4e0efe886721a3cc9eb3dac8b6761211d22c1b"

  on_macos do
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
