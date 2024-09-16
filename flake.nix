{
  description = "Nix flake for TDT4165 - Programmeringsspråk"; 

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      elixir = pkgs.beam.packages.erlang.elixir;
      elixir-ls = pkgs.beam.packages.erlang.elixir_ls;
      locales = pkgs.glibcLocales;
  in
  {
      devShells.${system}.default  =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.mozart2
            pkgs.scala_3
            pkgs.gprolog
pkgs.texlive.combined.scheme-full
            elixir
            locales
          ];


          shellHook = ''
            echo "Hello, world!"
          '';


        };
  };
}
