cask "rom2altsound" do
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "tar.gz", linux: "tar.gz"

  version "0.5.0"
  sha256 arm:          "1002966eb822bea427c54f61942f5e254ef3a6a68a5ba826334918e00bed7c56",
         intel:        "e5abf18d9ab13a4fd1c57741a76d9ed3aaa94cb581013324e1e51a71f14e77ec",
         arm64_linux:  "2f178c1a4a72541ff8299b85457f4d7027d64baab78dbb39cf9ec6e4591d232a",
         x86_64_linux: "767f1c03528f71cffeba32f77255846e6ec0483c12ac02c72b6e2c8d66fbc38e"

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
