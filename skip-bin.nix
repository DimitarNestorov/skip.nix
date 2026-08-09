{
  version ? "1.9.5",
  distribution ? "macos",
  url ? "https://github.com/skiptools/skip/releases/download/${version}/skip-${distribution}.zip",
  sha256 ?
    if distribution == "macos" then
      "sha256:0v1jx7dykdl1q7d48hjmyd1nyr4qilcd86hymmynk64zkhvxz17g"
    else
      "sha256:1scxi81xvqvig9qc8rkcj0jccdql5wqbxhkqpid9k048bbh3zhxr",
}:
builtins.fetchTarball {
  inherit sha256;
  inherit url;
}
