cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.31.0"
  sha256 arm:          "77ce4cdfedb96818be3695063ff56e4013ab47831077de5bd607bb5cee5b1c58",
         intel:        "4a00f8ed863215b2931d4e4cfc93e70c64f352c452f4c473cbaf987499efa24f",
         arm64_linux:  "0349357b0fa99329fdf5dfa49b417d6985cd7b7983b4bb7361995e2bf9f82a8d",
         x86_64_linux: "58e40f3b99486b0f5a4838f3a3355457e301462aac3676443a73bb356130466b"

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
