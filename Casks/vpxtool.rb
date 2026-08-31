cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.10"
  sha256 arm:          "a13aac970000f70f6e21437b1925adbd4a4edf00dff32f496389395305f50c9b",
         intel:        "6bc26abd4b7d7f8a39d790647e7ddd7697f5b5247b7d7bde9201fe80931e0255",
         arm64_linux:  "cc6621015e975394a6ef4d0bcdb8a42a1edd67cc0dba2bef853196c034d084b8",
         x86_64_linux: "3b33002e72568a009fbca863dd09be2d52d40b2a9f47304ff8361c1cd1441755"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
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
