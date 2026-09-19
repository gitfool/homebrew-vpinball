cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.2"
  sha256 arm:          "8381a486e47e3b8c33b79369d0977b7627b396ca24f82728bddd3d89c845d4f2",
         intel:        "919523a5710decd02888a7b30f5b66d68320b9314e240adaeae9088a5256bc0d",
         arm64_linux:  "d51428d975f5cc4e074c5e44b5fbddbfdec6877fcfb9c6b39c47e6877f10ee3b",
         x86_64_linux: "c4b03947582cfe112f3d34e94a70f999c64d9aa501a11f2b9a9db26bf09c9739"

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
