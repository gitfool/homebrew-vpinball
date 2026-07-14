cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.5"
  sha256 arm:          "3b38c49ef483387113e20323b3f101ba1dc0ef6438cb60d73d844f3504d0ff60",
         intel:        "d61ece4951ef547695e04633e01ee79e010ebb1b7a5784d327a199c282015e85",
         arm64_linux:  "98b26a4a33c5924f1541ec9d2ea413830ed4f43ee069aa950bd2e7761555b8c9",
         x86_64_linux: "1d4be028752583ff7c38ec52d8f216fa4c87b23345e21978132ab7a6b9c06d5b"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
