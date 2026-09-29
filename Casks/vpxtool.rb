cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.8"
  sha256 arm:          "d4ae03c92f5928b628a7d21472178be40aa248802c4af8c9e8db8f06ad7d304f",
         intel:        "3c03e172f3906ff482e1d051b7b8ea565f7c8ce5b76ff47d29ba441a1f1910af",
         arm64_linux:  "42ae7d5b303702ad58bfa9e8345038a90202df769dbde80a7b1cf1c89a1c26aa",
         x86_64_linux: "ade0a3c0a3bbb1b282dfac1447d820f78e059227ce7063029c15365660fa50d2"

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
