cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.6"
  sha256 arm:          "863cd148c3e263a460fb1e011ddba50c02e9c2e7198d62762ae7f2f8ce366dd4",
         intel:        "d29bcfe8f383ee6663af8e784f5069f3267ff91faab992850849235be27fa173",
         arm64_linux:  "f4070d08e8dacd1b97c9eac9f94c2a7dbbc383988f08a995f08b001af33f2d6a",
         x86_64_linux: "fe8f375d2cb797d4297736961a94582eed12ad023ab737e99ba30de8560a1f3f"

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
