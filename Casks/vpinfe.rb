cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "1.1.15"
  sha256 arm:          "6d2ebc875129c077dc2bd8c29e87340f9c055c760bae3d7f20de39cd653970a4",
         arm64_linux:  "6986794c5ca1825bf8ecb77c02068ef32421b3913ecbf8263cd2f87df235344f",
         x86_64_linux: "0a79925899353a6170388f21c8034255be2df021c38ef513d6d044fd0ce25fc6"

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
