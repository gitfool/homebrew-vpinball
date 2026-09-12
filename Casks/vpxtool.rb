cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.0"
  sha256 arm:          "46f6c7d8c3348ecff4c90e8b333a8ee9d1ef9e00631725dd21f03061b2b29113",
         intel:        "b64387c8acb0ea5abfe88e77a009cfadd19aab19502adc57ef983cac3b3b93e3",
         arm64_linux:  "cbb41d56e2dcb5d9de229e196505299b839fdadeecdd55ef187c54575240128e",
         x86_64_linux: "4d234dc0fe7da70f64046d752b26ac1d0c06e51f0c4a68d7511d7697b5e19771"

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
