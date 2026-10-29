cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "12899148164", intel: "12898903195"),
                                      linux: "12898989179"

  version "10.8.1-6489-aeeedc533"
  sha256 arm:          "817ce63f838f21866e1791e8508e2727ea1b7dc6e2aa522c160ffafbe0ba451d",
         intel:        "03c616fd7a5cdd098bc5198fff873f7e4945dea8b91fe7ced2d64072fabf69de",
         x86_64_linux: "25f34ba1ad1171402b83b82ae3a45f0d17676a5ca041c97c7aa5dd82a2455002"

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
