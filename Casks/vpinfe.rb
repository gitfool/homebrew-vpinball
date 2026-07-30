cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.5.2"
  sha256 arm:          "f8063fdf8308fa103af4ec6de26029bd69968446709970e6acc3f43c45092253",
         arm64_linux:  "a4f40ade01cb620bcba5135f99a54f53875c93809856a1421854a26d78b9c75a",
         x86_64_linux: "9e362deabd961d3ce5efbc7cff198ce2b0a9858c20d89f3d0d5d00b1f68f9af3"

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
