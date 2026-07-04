cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.14.2"
  sha256 arm:          "f314adf24656dec29d89a8926131205d90b31043507be3fe13cb65fdd1c592ac",
         intel:        "98b696cfc3d0ca74e41c70794d7de764932f829ab607806d9d17109c2ac07605",
         arm64_linux:  "813e83b820f1f7316149b5206402e56584b9cad2f94ab04e8a7698ba097c2276",
         x86_64_linux: "beeac983f5a1b628208b1360924a61e5ca3a15c0c74708a52f94beb416901e74"

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
