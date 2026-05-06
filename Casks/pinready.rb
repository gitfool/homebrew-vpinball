cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.13.0"
  sha256 arm:          "d3d74c969e2415a2de53372a7b0e946037487abd29dd43d24e33544b45dd3279",
         intel:        "229f3a99597f3a886934edee8ad32a43d45f1b43f6a87e48abd66ba62e85e24f",
         arm64_linux:  "7d05331616ba5568c0785df34b9927c74a9c625e8289aa7826a8b2320832d85a",
         x86_64_linux: "914ede4fee88622ab9291da24bf9323895deb971f0a0e188d254832479526ff5"

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
