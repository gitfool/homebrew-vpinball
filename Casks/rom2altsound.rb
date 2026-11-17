cask "rom2altsound" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "tar.gz", linux: "tar.gz"

  version "0.6.0"
  sha256 arm:          "4a1747da875999db90907c780a7676059b9314d2d7d1b2a8672fb56df233c75a",
         intel:        "4a8b1805e3f7f0ece20040a51d138faf1003e255b1a908b43fed2a6c122e97c7",
         arm64_linux:  "0faacf7f12767a2559ebe9819d498787d11ef7de4d2c38945ab64855d7355819",
         x86_64_linux: "ee84f5fed1f7ca597feda9eab964bb9ac3413ed36b196e7478229f2bb4241d8d"

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
