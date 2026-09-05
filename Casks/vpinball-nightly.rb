cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "9972976810", intel: "9972969757"),
                                      linux: "9973160089"

  version "10.8.1-5576-3dc4bec51"
  sha256 arm:          "5bfc198c6baaec7a311da7ded701e68f451c7bc33c7482e0a7b9538f742317e3",
         intel:        "3ec9fa1ba52f7a1c10f74c6cd2b669f8b6541f0ebb57845b6ad01e49a0489c78",
         x86_64_linux: "3fad81a243230ae8c77144f7d0fcd8b7cf01040ba957450022a7cc80bdda6f78"

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
