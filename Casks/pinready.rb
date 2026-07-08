cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.17.1"
  sha256 arm:          "43e04b60daa8de9ea36843ee11e41cbbe3a43a64b7484474e12c8d8f074e0845",
         intel:        "d604ce3957e184e9fddfed6314224dd468d3fcf5a0f75d7249ab2577df5dad4f",
         arm64_linux:  "d305606d8ba97ca1b943842a94e6b3d7b02f910a2b42171a32484d690952440f",
         x86_64_linux: "68439f876f4e7803e3a6ff1631cf38ddb64d9dd9e9e81a895ac0681c8549af48"

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
