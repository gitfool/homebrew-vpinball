cask "vpinfe-slim" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "1.1.51"
  sha256 arm:          "0e117f030fa47ce4ecdcc7d756bf383366d1cc060c40b463deaac2fed832446c",
         arm64_linux:  "1eb47887c9f1aae729678b9aa485a19332a31550c6af3d1088b35c9e81c32516",
         x86_64_linux: "89d9ca4d452e0ef163b195a78c86f7a8a302e464412da351e319c263ddd3ea40"

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
