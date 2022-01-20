{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "docker-python-minimal";
  buildInputs = with pkgs; [
    docker
    gnumake
  ];
}
