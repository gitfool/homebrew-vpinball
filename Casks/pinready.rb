cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.6.2"
  sha256 arm:          "2039471c930536d3318715b31d169f985cb918b7d7b42b1cef9fc19e2fe736ca",
         intel:        "79bdfe3de8ca74d4d8db3a90a97107a68e4890149d8f80c0164b494f5fb82ef7",
         arm64_linux:  "95363106991e06375d64ab57fcadea888ede02085b278e21f6c6968cef94e4f4",
         x86_64_linux: "15d7506788d513a417cc9073d23c652870cd34e8d2b26fbe1ffbe707437752a9"

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
