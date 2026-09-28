cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.21.1"
  sha256 arm:          "a8352e026a723044daf24fe7f161cd36427b9d936028e0ec087d7963f219a360",
         intel:        "78db7e43f9f04d9b4b627b84b5520350d39c0f36e88a3dd608ccc6c85a43b373",
         arm64_linux:  "12db7d2960b3972ab845941649c2d21527960e270b26d84a00fe6c646f4d1078",
         x86_64_linux: "49784d7b1c7b8fe690e6a9acb27f6276cf82c69926a2744f12572d4edcd16e65"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/pinready"]
    end
  end

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
