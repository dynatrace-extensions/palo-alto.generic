# Palo Alto Generic Extension
First EF2.0 extension targeting Palo Alto firewall devices

## Usage
For now go for [dev](#dev)

## Dev

### Prerequisites
- [nix](https://nixos.org/nix/manual/#chap-installation)
- `direnv` (`nix-env -iA nixpkgs.direnv`)
- [configured direnv shell hook ](https://direnv.net/docs/hook.html), yup in your `.bashrc`
- some form of `make` (`nix-env -iA nixpkgs.gnumake`)
- Docker

Hint: if something doesn't work because of missing package please add the package to `default.nix` instead of installing on your computer. Why solve the problem for one if you can solve the problem for all? ;)

### One-time setup
```
make init
```

### Everything
```
make help
```

## Origin
This extension is based on EF1 Palo Alto plugin and can be considered a port.
