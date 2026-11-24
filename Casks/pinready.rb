cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.30.3"
  sha256 arm:          "e737f1ab6c7af9e076237d9e759377a691a2d808037dd0d13a22cfe2c8004710",
         intel:        "fe9347b015cafad2d9e520805e198d3787b00d770b932d5b48a6b34555880912",
         arm64_linux:  "43e4d1b970e095ed59d40476a0dd0943e2de0ae2fd2ecd979752f482b6285ace",
         x86_64_linux: "38c5f5313d37cc0eaaae4f4ca78c97a98927ef54a017019b246a959ee2f2062b"

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
