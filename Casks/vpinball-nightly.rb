cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "10.8.1-4758-1efeb07"
  sha256 arm:          "69e948b789160866d262f67f2127ca3d93b21909a39928c90b47882bf668b350",
         intel:        "59668c0e17435bfc8ee9a3fea249130ac27b6905cb05ea2f9264306313a7dfad",
         x86_64_linux: "729ef20d9d24405dabf442892c7c5eb957801e6744b5d14285817aa5a67e8652"

  url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master/VPinballX_BGFX-#{version}-#{os}-#{arch}-Release.zip",
      verified: "nightly.link/vpinball/vpinball/"
  name "VPinballX BGFX nightly"
  desc "Visual Pinball BGFX nightly"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview"
    regex(/VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release.zip"/)
  end

  depends_on macos: ">= :sonoma"

  on_macos do
    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"
  end

  on_linux do
    binary "VPinballX_BGFX"
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
