{
  version ? "1.9.13",
  distribution ? "macos",
  url ? "https://github.com/skiptools/skip/releases/download/${version}/skip-${distribution}.zip",
  sha256 ?
    if distribution == "macos" then
      "sha256:08i2qk2sw0xs0qffm26c6smlrqbvhhzrj39zhf2bsk0bq4z3d1sn"
    else
      "sha256:0b3378vkbmbcr1c27mh1ch9i4118ys2jnnvf05g63bcp5khqcbrz",
}:
builtins.fetchTarball {
  inherit sha256;
  inherit url;
}
