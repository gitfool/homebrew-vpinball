cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.14.0"
  sha256 arm:          "af483a2525eeba04cf53423764ed0538095d7a768276f51ca2ed9fa292b42cbc",
         intel:        "24924bcd734e33f79896687f7a04049eb2f1e406c61d4661abab3a9e26e06a8d",
         arm64_linux:  "5bff244ab4b678ac7be64d12b45688ef5883d0c3e9d9b57b970bffb195c6cf99",
         x86_64_linux: "4f2eaed7f0c5b48129af0eb222e5903e1269cfb7abd9d1645e7e2ff97bdfd068"

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
    end
  end

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
