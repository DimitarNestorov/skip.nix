{
  version ? "1.8.14",
  distribution ? "macos",
  url ? "https://github.com/skiptools/skip/releases/download/${version}/skip-${distribution}.zip",
  sha256 ?
    if distribution == "macos" then
      "sha256:0376zkq3vh8gw36f2d2j65q8qf5crkf7jzi0cwhkm2825j0v77cn"
    else
      "sha256:0cxb6ra0znnjimfh2jhc07mqcg02lya6df8py2593ylyy787kg8a",
}:
builtins.fetchTarball {
  inherit sha256;
  inherit url;
}
