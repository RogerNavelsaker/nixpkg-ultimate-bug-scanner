{
  bash,
  coreutils,
  curl,
  fetchFromGitHub,
  findutils,
  gawk,
  git,
  gnugrep,
  gnused,
  jq,
  lib,
  makeWrapper,
  python3,
  ripgrep,
  stdenvNoCC,
  unzip,
}:

let
  manifest = builtins.fromJSON (builtins.readFile ./package-manifest.json);
  sourceRoot = fetchFromGitHub {
    owner = manifest.source.owner;
    repo = manifest.source.repo;
    rev = manifest.source.rev;
    hash = manifest.source.hash;
  };
  licenseMap = {
    "MIT" = lib.licenses.mit;
    "Apache-2.0" = lib.licenses.asl20;
  };
  resolvedLicense =
    if builtins.hasAttr manifest.meta.licenseSpdx licenseMap
    then licenseMap.${manifest.meta.licenseSpdx}
    else lib.licenses.unfree;
in
stdenvNoCC.mkDerivation {
  pname = manifest.binary.name;
  version = manifest.package.version;
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp "${sourceRoot}/${manifest.binary.path}" "$out/bin/${manifest.binary.name}"
    chmod +x "$out/bin/${manifest.binary.name}"
    patchShebangs "$out/bin/${manifest.binary.name}"
    wrapProgram "$out/bin/${manifest.binary.name}" \
      --prefix PATH : ${lib.makeBinPath [
        bash
        coreutils
        curl
        findutils
        gawk
        git
        gnugrep
        gnused
        jq
        python3
        ripgrep
        unzip
      ]}
  '';

  meta = with lib; {
    description = manifest.meta.description;
    homepage = manifest.meta.homepage;
    license = resolvedLicense;
    mainProgram = manifest.binary.name;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
