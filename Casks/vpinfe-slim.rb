cask "vpinfe-slim" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.1.7"
  sha256 arm:          "486ca89580a24ed7c2599c257f57cab863197c8883ac2ecbe7d3916c967ce41f",
         arm64_linux:  "de52ef3f67f6afa660b1d4f479711b0172f6344921f61bd271f853a87d165bcb",
         x86_64_linux: "0f72042bd31c09ece191f6e052b73708e3e5335b1fa0dafdc35f535791d74bc4"

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
