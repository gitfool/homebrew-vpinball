class Vpxtool < Formula
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/francisdb/vpxtool/releases/download/v0.25.0/vpxtool-macOS-aarch64-v0.25.0.tar.gz"
      sha256 "b7e6d380c9145e8974c82ae7de4072916106909c0408948f1aa74a4df7d58f17"
    end

    on_intel do
      url "https://github.com/francisdb/vpxtool/releases/download/v0.25.0/vpxtool-macOS-x86_64-v0.25.0.tar.gz"
      sha256 "c30ff47364b4249bd10d5e8966bea3f613a572c7b49b4bbcfd5f1991d4bf3a43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/francisdb/vpxtool/releases/download/v0.25.0/vpxtool-Linux-aarch64-musl-v0.25.0.tar.gz"
      sha256 "ec8bef31f7e23ae9f6324355e23de8a83830d037b9c5e799637627ee60308056"
    end

    on_intel do
      url "https://github.com/francisdb/vpxtool/releases/download/v0.25.0/vpxtool-Linux-x86_64-musl-v0.25.0.tar.gz"
      sha256 "d88b77861c7cb7a4e0204a5356ac9a3994a23bc2b6d09d1d8622d22e9d3a1eac"
    end
  end

  def install
    bin.install "vpxtool"
  end
end
