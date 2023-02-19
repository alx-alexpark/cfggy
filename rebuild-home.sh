#!/bin/sh
pushd ~/cfggy
nix build .#homeManagerConfigurations.alx.activationPackage
./result/activate
popd
