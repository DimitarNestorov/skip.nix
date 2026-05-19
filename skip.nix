{
  lib,
  stdenvNoCC,
  versionCheckHook,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "skip";
  version = "1.8.14";

  src = fetchTarball {
    url = "https://github.com/skiptools/skip/releases/download/${finalAttrs.version}/skip-macos.zip";
    sha256 = "sha256:0376zkq3vh8gw36f2d2j65q8qf5crkf7jzi0cwhkm2825j0v77cn";
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
    mv macos/skip $out/bin

    runHook postInstall
  '';

  meta = {
    mainProgram = "skip";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
