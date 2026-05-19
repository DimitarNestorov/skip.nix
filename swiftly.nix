{
  cpio,
  fetchurl,
  gzip,
  lib,
  stdenvNoCC,
  xar,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "swiftly";
  version = "1.1.1";

  src = fetchurl {
    url = "https://download.swift.org/swiftly/darwin/swiftly-${finalAttrs.version}.pkg";
    sha256 = "0ryg2si7d2mkkrfn4lz672js86s2279pdqh1iwb3iwyrx16jz4wk";
  };
  dontUnpack = true;
  dontBuild = true;
  dontPatch = true;
  dontConfigure = true;
  dontFixup = true;

  nativeBuildInputs = [
    cpio
    gzip
    xar
  ];

  installPhase = ''
    runHook preInstall

    xar -xf $src
    gunzip -dc swiftly-${finalAttrs.version}.pkg/Payload > decompressed.out
    cat decompressed.out | cpio -it | grep -v '/._' > file-list-no-resource-forks.txt
    cat decompressed.out | cpio -i -E file-list-no-resource-forks.txt

    mkdir -p $out
    mv bin $out
    mv share $out

    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
    writableTmpDirAsHomeHook
  ];
  versionCheckProgramArg = "--version";
  versionCheckKeepEnvironment = [
    "HOME"
    "SWIFTLY_HOME_DIR"
  ];
  preVersionCheck = ''
    export SWIFTLY_HOME_DIR=$HOME/swiftly
    export SWIFTLY_TOOLCHAINS_DIR=$SWIFTLY_HOME_DIR/toolchains
    export SWIFTLY_BIN_DIR=${placeholder "out"}/bin
    ${placeholder "out"}/bin/swiftly init --skip-install --no-modify-profile --assume-yes
  '';

  meta = {
    mainProgram = "swiftly";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
