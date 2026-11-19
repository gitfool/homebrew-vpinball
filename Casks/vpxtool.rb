cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.40.3"
  sha256 arm:          "14323dbbfa4b61964b00638f0270d01378682c65c8128259e8bf22c811318d77",
         intel:        "376751b6d4ebae41bfc9ba20c0098d0bcc8863bd71ce7e773a84c706addb24a5",
         arm64_linux:  "0e96045848d2fa52394e7793adc1ecc35a3abb396d65042d1b52e180eda01b0f",
         x86_64_linux: "986a22fffd89a31fa2975c8c96806ed4c6cf4502a1d438a7ece883641ba8b1b5"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/vpxtool"]
    end
  end

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
