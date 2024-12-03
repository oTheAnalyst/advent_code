{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    rPackages = with pkgs.rPackages; [
      tidyverse
      reactable
      rstudioapi
      httpgd
      here
      lintr #essential
      languageserver #essential
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      buildInputs = with pkgs; [
        pandoc
        glibcLocales
        nix
        gnumake
        libgcc
        gccgo
        neovim

        (rWrapper.override {packages = rPackages;})
        (rstudioWrapper.override {packages = rPackages;})
      ];
    };
  };
}
