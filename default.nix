# FIME: https://github.com/NixOS/nixpkgs/issues/11133

{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let

  version = "0.0.1";

  env = bundlerEnv {
    name = "nix-ruby-json-${version}-env";
    inherit version ruby;
    gemdir = ./.;
  };

in

stdenv.mkDerivation rec {
  name = "nix-ruby-json-${version}";
  inherit version;

  buildInputs = [ env.wrappedRuby ];

  script = ./script.rb;

  buildCommand = ''
    mkdir -p $out/bin
    install -D -m755 $script $_/script
    patchShebangs $_
    sed -i "s#/bin/ruby#/bin/ruby ${script}#" $_
  '';

  meta = with lib; {
    description = "Getting the json gem to build via Nix";

    homepage = https://github.com/yurrriq/nix-ruby-json;
    license = licenses.unlicense;
    maintainers = with maintainers; [ yurrriq ];
    inherit (ruby.meta) platforms;
  };
}
