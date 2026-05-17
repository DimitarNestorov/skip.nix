{
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fake-brew";
  version = "5.1.11";

  src = null;
  dontUnpack = true;

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/bin

    cat > $out/bin/brew <<'EOF'
    #!/bin/bash

    echo "Homebrew ${finalAttrs.version}"

    exit 0
    EOF

    chmod +x $out/bin/brew

    runHook postBuild
  '';

  meta = {
    mainProgram = "brew";
  };
})
