cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.8"
  sha256 arm:          "da0723cf41850baabfbdd29b36b107df53c5a45fc19dc693bc28622790fbae47",
         intel:        "4a6a1d07ac66aa21ca604c830d0c371e70d7fdd48e80d214e70930455c5ce8b9",
         arm64_linux:  "97a9b079c2c4b2d3cb0651f1a26e5ce1f4039c5928dbc27f91d7494a9c202335",
         x86_64_linux: "c9f765858109dc6d54e10d8a2a86c9fdcdeda0fb52bbaae15e2f89b49a55a03a"

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
