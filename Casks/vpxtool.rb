cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.37.1"
  sha256 arm:          "10c72247031f31c553e6d8c0d9b08d8fb2c8a1e3b3fbedb46a9cc443b532e6ae",
         intel:        "4b46415789140f2f8b1f4715b67ebd9a47453685aeff8764b7357b7ddb39eddd",
         arm64_linux:  "802793b787a3ed6c373bcb1aabac3d71d59be69f7818b8c0a6222aac06c48f40",
         x86_64_linux: "5bdd17d6c87d8e6d5130d72e67dc53233c7ef698408bab3711a453173124a193"

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
