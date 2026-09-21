cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "10613331283", intel: "10613107734"),
                                      linux: "10612612494"

  version "10.8.1-5773-676b19ec0"
  sha256 arm:          "934afb8952912d913fb1a079dd344850359c68690047d1b33de3f6687be2e927",
         intel:        "c796e338216c122de47e3e776dff8c0b0feb660b5bddf67f4466b77ddfe56f9c",
         x86_64_linux: "9031c35cdbaf287e58f8d685e95b3db40cbc3535aa021422f4dca7afa2426959"

  on_macos do
    depends_on macos: :sonoma

    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPinballX_BGFX.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPinballX_BGFX"
  end

  url "https://api.github.com/repos/vpinball/vpinball/actions/artifacts/#{artifact_id}/zip",
      header: "Authorization: token #{GitHub::API.credentials}"
  name "VPinballX BGFX (nightly)"
  desc "Visual Pinball BGFX (nightly)"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview"
    regex(/VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release\.#{ext}"/)
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
