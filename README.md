# windicss-nix

To build,

```
nix-build -A shell.nodeDependencies
```

To update,

```
nix-shell -p nodePackages.node2nix --run 'node2nix'
```

## Docker image

Docker image is built in CI for `master`. You can use it as:

```
docker run --rm -it sridca/windicss
```
