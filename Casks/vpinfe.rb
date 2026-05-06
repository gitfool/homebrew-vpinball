cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.2.0"
  sha256 arm:          "8635cb6a34d4658d72c10c0ab8dac7c862b43f30ffe5cbc460d2158713ab9f0e",
         arm64_linux:  "83a7997c6c65a968461855c9851767022e0dc6c9943a164b6316ead588af9587",
         x86_64_linux: "0b2831a9f96db7953177f4902636512b46293305df1786c451d9aa70ea38f056"

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
