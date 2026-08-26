cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.20.1"
  sha256 arm:          "228f0f106e28dd5d4eac6693200252df94ce10c76c0c53eb82b51c83a56efd0e",
         intel:        "62db611e1e75cd8baadf3b5aedd721e9da1c66442c8c25b3322c1027c09fa337",
         arm64_linux:  "f29a1e7e1230298fd1a9ee5e66d26852e6a69ef48a62c21b9e9fac58f340905d",
         x86_64_linux: "92408a9f588a62599d408bfff38163f79d4fddd956f6ff76c7fc29f1f6ea553f"

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
