cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.6.3"
  sha256 arm:          "b4a54b70a374cf5ba0ff202d468d7f116cfa11df5a9e9e01b5f347e902039b96",
         arm64_linux:  "1d23e1054f37bd639e1ab5a5c3d5bc74bbf19714ee2ad6c101b74e6f91101a44",
         x86_64_linux: "66763a87c89896b2a0053b46405b8add94f56301752fbf03960d05671891847a"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    app "VPinFE.app"
    binary "#{appdir}/VPinFE.app/Contents/MacOS/VPinFE", target: "vpinfe"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPinFE.app"]
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
