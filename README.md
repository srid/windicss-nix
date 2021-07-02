# windicss-nix

To build,

```
nix-build -A shell.nodeDependencies
```

To update,

```
nix-shell -p nodePackages.node2nix --run 'node2nix'
```