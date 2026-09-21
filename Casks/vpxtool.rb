cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.6"
  sha256 arm:          "68fde3b52729c01ae42f6783590a1b370a59830439337ab1d40e3962b3888a8c",
         intel:        "b32860b0ca3aaa96917c0f3e8e7c2e5a176ab8e5f30a16d19d79207332524e62",
         arm64_linux:  "6347b43b5e80f4f5b14fb781c352daf2763ebd71315f0f177699ea0d099d04e8",
         x86_64_linux: "6500c27ad8755841ac2ed13b86b4f3e89e4069a957047c91ab638ab7f2cf9317"

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
