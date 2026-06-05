{
  version ? "1.8.14",
  sha256 ? "sha256:0376zkq3vh8gw36f2d2j65q8qf5crkf7jzi0cwhkm2825j0v77cn",
}:
builtins.fetchTarball {
  inherit sha256;
  url = "https://github.com/skiptools/skip/releases/download/${version}/skip-macos.zip";
}
