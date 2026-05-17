{
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  name = "swiftly-symlink";

  src = null;
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    ln -s "${finalAttrs.homeFolder}/.swiftly/bin/swiftly" $out/bin/swiftly

    runHook postInstall
  '';

  meta = {
    mainProgram = "swiftly";
  };
})
