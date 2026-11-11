cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.4"
  sha256 arm:          "5b3115baaedaf3d2c5a32501e17ec6e35372fff96f18a4a07365bc922ad76f97",
         intel:        "4110e6f4465fe773dbce69dac1656e3ebd1bd3cea3a3a199b42da5faa71a4f5e",
         arm64_linux:  "d6aaeb037b1cf95d76b789bae05c3757976edf383cba5b069c9f31ee08f1bc14",
         x86_64_linux: "413acb0da7a04e2aac7670fe595b4f3abb5029ec7d1d34d2bd0be9aa40aef886"

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
