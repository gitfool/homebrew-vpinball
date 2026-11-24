cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "14947779973", intel: "14950670160"),
                                      linux: "14949636116"

  version "10.9.0-6999-ca88fd768"
  sha256 arm:          "84bd1be9b12bb575fba6b614f4305d3cf57919f425507325f0e1afc7889e6ac9",
         intel:        "0dbafde1a62f8a609e0d12d764e1293638fda4848446285147a1d012b952f3ad",
         x86_64_linux: "692694e38b8198a0a3300e4fcd845063d40c3b3b2a159b157b5f6ba263259493"

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
    # Get unfiltered runs; branch/event/status filters intermittently return stale partial results
    url "https://api.github.com/repos/vpinball/vpinball/actions/workflows/vpinball.yml/runs?per_page=10",
        header: ["Authorization: token #{GitHub::API.credentials}", "Accept: application/vnd.github+json"]
    regex(/^VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release\.#{ext}$/)
    strategy :json do |json, regex|
      json["workflow_runs"]
        .select { |run| run["head_branch"] == "master" && run["event"] == "push" && run["conclusion"] == "success" }
        .sort_by { |run| -run["run_number"] }
        .lazy
        .map { |run| GitHub::API.open_rest("#{run["artifacts_url"]}?per_page=100")["artifacts"] }
        .map { |artifacts| artifacts.reject { |artifact| artifact["expired"] } }
        .map { |artifacts| artifacts.filter_map { |artifact| artifact["name"][regex, 1] } }
        .find(&:any?) || []
    end
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
