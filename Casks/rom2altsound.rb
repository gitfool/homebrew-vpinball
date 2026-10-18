cask "rom2altsound" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "tar.gz", linux: "tar.gz"

  version "0.4.0"
  sha256 arm:          "86e6a2dbd20418fcc193b4c8bb65a477c8146e2b4ec6835dce706415dd7dd9f0",
         intel:        "3e99b50b6f14bd64964f5258db763fb79b035575c22524534844b02cf2b30715",
         arm64_linux:  "39f7e8afc0026b4fac7cb8829617e252c3f15df30d4d65327823810754e023b7",
         x86_64_linux: "80913cd79892f67a8a05567c04626ad2427307ab6d5aa786c159c12fbc0c4fc0"

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
