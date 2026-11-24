cask "rom2altsound" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "tar.gz", linux: "tar.gz"

  version "0.7.0"
  sha256 arm:          "bb6fd8a2e1d09b3abe3e967246d23a8d66b99133ba97cccc4233827394faed20",
         intel:        "dd4222f5d91c37e9566418ee74e7d0e605f12951c683b36a8beba3794d082341",
         arm64_linux:  "6039c2a0a4ea2bc446707ddaa2f512938448d065fc2d26436e11b25ccf6d3ffe",
         x86_64_linux: "12227619927b3618603eb4d544f74670b7b35fd607469490af9fe724d360c806"

  on_macos do
    arch arm: "arm64", intel: "x86_64"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/rom2altsound"]
    end
  end
  on_linux do
    arch arm: "aarch64", intel: "x86_64"
  end

  url "https://github.com/Le-Syl21/rom2altsound/releases/download/v#{version}/rom2altsound-#{os}-#{arch}.#{ext}"
  name "rom2altsound"
  desc "Extract every sound of a PinMAME ROM for AltSound"
  homepage "https://github.com/Le-Syl21/rom2altsound"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "rom2altsound"

  zap trash: [
    "~/.cache/rom2altsound",
    "~/Library/Caches/rom2altsound",
  ]
end
