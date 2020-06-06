let
  commitRev = "73fb59dbb89ed5f754249761dcd99c6ccbd24bb5"; # 19.09
  nixpkgs = builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs-channels/archive/${commitRev}.tar.gz";
  };
  pkgs = import nixpkgs { config = { }; };
in pkgs.mkShell {
  name = "nixops";
  buildInputs = with pkgs; [ zsh nixops ];
  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:."
    zsh
  '';
}
