{
  lib,
  stdenvNoCC,
  versionCheckHook,
}:

# TODO: Optionally wrap with Gradle and Android Tools
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "skip";
  version = "1.8.14";

  src = import ./skip-bin.nix {
    version = finalAttrs.version;
    distribution = if stdenvNoCC.hostPlatform.isDarwin then "macos" else "linux";
  };

  dontBuild = true;
  dontFixup = true;

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  versionCheckProgramArg = "version";
  doInstallCheck = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    ${
      if stdenvNoCC.hostPlatform.isDarwin then
        ''
          mv macos/skip $out/bin
        ''
      else
        ''
          mv ${stdenvNoCC.hostPlatform.qemuArch}-swift-linux-musl/skip $out/bin
        ''
    }

    runHook postInstall
  '';

  meta = {
    mainProgram = "skip";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
