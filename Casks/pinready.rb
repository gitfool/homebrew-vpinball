cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.9"
  sha256 arm:          "c9d9d20fa7299b19ef26ceb26a9ccc8292c4810b57cfd65e69770fa9e3bbd9b8",
         intel:        "7e02b221edcdbe15215b3274e5d790295df177b387d88778101e4130839ae7e0",
         arm64_linux:  "20c8e57766ba57707bd08f85d8af0df967cb67527dab2fa7a123efa4a8c758ea",
         x86_64_linux: "ac79e07009ec25ef46a4e18fc3a0279d92ba307b7879f9b189fe6f80ed8568b3"

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
