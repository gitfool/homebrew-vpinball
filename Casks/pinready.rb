cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.0"
  sha256 arm:          "7efff492ff0c893fa24de679240ac7e6ea7b44c613f1334f117bf03264bf569a",
         intel:        "86842b98b71baf4e84b0fce4de006345d900a4c61308a918331797c9367a05be",
         arm64_linux:  "d02e69354ef984af015bc29a3310a36cb06ce02311786b382b0e4af4d20d7f17",
         x86_64_linux: "31fde115d9076236af5b67f959cfa32fd3ae8dcd3209e670d9a4a6df349741fe"

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
