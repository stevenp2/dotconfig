{
  description = "nix flake for hackrfone setup with gnuradio";

  inputs = {
    # Nixpkgs is the package repository for Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, home-manager }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    # Create a development shell environment
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.hackrf
        pkgs.gnuradio
        pkgs.gqrx
      ];

      # Optional: Add extra setup or environment variables
      shellHook = ''
        echo "hackrf tools and gnuradio are available"
      '';
    };

    # Optional: Provide a default application configuration
    apps.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.hackrf
        pkgs.gnuradio
        pkgs.gqrx
      ];
    };
  };
}
