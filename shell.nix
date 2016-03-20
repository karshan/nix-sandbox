{ }:
let this = import ./. {};
    nixpkgs = import ./nixpkgs ({
      config = {
        allowUnfree = true;
        allowBroken = true;
      };
    });
    ghcjs = (import ./. { }).ghcjs;
    ghc = (import ./. { }).ghc;
in nixpkgs.runCommand "shell" {
  buildCommand = ''
    echo "$propagatedBuildInputs $buildInputs $nativeBuildInputs $propagatedNativeBuildInputs" > $out
  '';
  buildInputs = [
    nixpkgs.nodejs
    nixpkgs.curl
    ghc.cabal-install
    ghc.ghcid
    ghc.cabal2nix
  ] ++ [ (ghcjs.ghcWithHoogle (p: import ./packages.nix { haskellPackages = p; platform = "ghcjs"; })) ]
    ++ [ (ghc.ghcWithHoogle (p: [ p.servant ])) ];
} ""