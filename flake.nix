{
  description = "Sample Nix Flake";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
      devShells.${system}.default  =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.mozart2
            pkgs.scala_3
            pkgs.gprolog
          ];


          shellHook = ''
            echo "Hello, world!"
          '';


        };
  };
}
