cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.1"
  sha256 arm:          "37f85e4adb244cc09a0be7ac058f388c237aa66c3b068fe73ed022e01d5a1339",
         intel:        "734a1fd71964ad8063d3289b3df6546e7e62a3a22e2ff98a3628287418b7abb7",
         arm64_linux:  "c28274517c28ee01a8ba2efa5f5aec2000b7799e480da5ae1afcb4c49f2ebd39",
         x86_64_linux: "a566bdbfca6efb63f5f7f8656ac81e8e52e326170235638a3d0e7e550c78aece"

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
