{ }:
let nixpkgs = import ./nixpkgs ({
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
    nixpkgs.nix-serve
    ghc.cabal-install
    ghc.ghcid
    ghc.cabal2nix
  ] ++ [ (ghcjs.ghcWithHoogle (p: [ p.reflex p.reflex-dom p.ghcjs-servant-client])) ]
    ++ [ (ghc.ghcWithHoogle (p: [ p.servant_0_5 p.HandsomeSoup p.acid-state p.base64-bytestring p.cryptonite p.data-default-class p.either p.http-client p.hxt p.lens p.lens-aeson p.memory p.network p.pretty-show p.safecopy p.servant-server_0_5 p.split p.wai p.warp p.wreq ])) ];
} ""
