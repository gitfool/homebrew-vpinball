cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.9.0"
  sha256 arm:          "bd4286f0717835079712f58ce54d69e0b9233727d8170e3d4933fdfcf87ae062",
         intel:        "325ed970fcd253b5986326d57d03ba9d3791cf6a13a714082d1d70e6f9029107",
         arm64_linux:  "15f3872d46935eb86657e71a7a50fba30beddd5d24bdf34c9fbf1400a02eda78",
         x86_64_linux: "408bd838d3158970c3246e52f8f8cb835242e1e97378f488bfd88e507ca5f0c7"

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
