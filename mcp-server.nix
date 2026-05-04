{
  buildNpmPackage,
  npmDepsHash,
  nodejs,
  lib,
  stdenv,
  playwright-driver,
  browserProgram ? if stdenv.targetPlatform.isLinux then "chrome" else "Chromium",
}:
let
  browsers =
    if stdenv.targetPlatform.isLinux then
      playwright-driver.browsers.override {
        withFirefox = false;
        withWebkit = false;
        withFfmpeg = false;
        # fontconfig_file = { fontDirectories = []; };
      }
    else
      playwright-driver.browsers;

  versionSpec = (lib.importJSON ./package.json).dependencies."@playwright/mcp";

  versionMatch = builtins.match "\\^([0-9]+(\\.[0-9]+)+)" versionSpec;

  version = if versionMatch == null then "unknown" else builtins.elemAt versionMatch 0;
in
buildNpmPackage {
  pname = "playwright-mcp";
  src = ./.;
  inherit version npmDepsHash;

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  postInstall = ''
    bindir="$out/lib/node_modules/nix-playwright-server/node_modules/.bin"

    makeWrapper $(realpath "$bindir/playwright-mcp") $out/bin/playwright-mcp \
      --chdir "$bindir" \
      --add-flags "--executable-path '$executable'"
  '';

  meta = {
    description = "Playwright Tools for MCP";
    homepage = "https://github.com/microsoft/playwright-mcp";
    license = lib.licenses.asl20;
    inherit (nodejs.meta) platforms;
  };
}
