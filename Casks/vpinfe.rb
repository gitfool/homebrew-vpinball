cask "vpinfe" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "2.6.2"
  sha256 arm:          "0d65145b3a8a8edd3bc8ed19e8cc9601e4c542c1be7afe7d0494eca6476fa882",
         arm64_linux:  "0617daafd517ebf2bd038859d77409de5e19155538be9426ae6fbbe303a6e2ec",
         x86_64_linux: "9a540ed49ac7b6c4aca56e56bed8f23daf71f6c8341b5ebef6debe65285e3b9b"

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
