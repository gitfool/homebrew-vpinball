cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.19.0"
  sha256 arm:          "a08c3393ba71bb8976830e453f5733f7b71091c039d6a3473449136a5f60fbc2",
         intel:        "98be17091668a925c5a25a97289a93ea7f8c1ea6d9168ade0f6a41cc9ab94e1e",
         arm64_linux:  "132980b24372c244df986f086a023ecce1f562de4da0f0e077acd419a1d01359",
         x86_64_linux: "82de188203afebae18e6dcf6bf0dfdf98cd1127f2dc951bb87c44bd9057544f1"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
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
