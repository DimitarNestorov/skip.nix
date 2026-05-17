{
  homeFolder ? "/Users/dimitar",
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

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  versionCheckProgramArg = "version";
  doInstallCheck = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv macos/skip $out/bin

    cat > $out/bin/brew <<'EOF'
    #!/bin/bash

    echo "Homebrew 5.1.11"

    exit 0
    EOF

    ln -s "${homeFolder}/.swiftly/bin/swiftly" $out/bin/swiftly

    chmod +x $out/bin/brew

    runHook postInstall
  '';

  meta = {
    mainProgram = "skip";
  };
})
