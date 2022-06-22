let
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs-channels/";
    ref = "refs/heads/nixos-unstable";
    rev = "4762fba469e2baa82f983b262e2c06ac2fdaae67"; # 22-06-2022
    # obtain via `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
  };
  pkgs = import nixpkgs { config = {}; };
  markdown-table = with pkgs.python38Packages; buildPythonPackage rec {
      pname = "markdown-table";
      version = "2020.12.3";

      src = fetchPypi{
        inherit version;
        inherit pname;
        sha256 = "0gqr46rh7m6b5qcdmpbxrbvzi0yniaksbak1mcfkn60ldplfh3fz";
      };
  };
  click-aliases = with pkgs.python38Packages; buildPythonPackage rec {
      pname = "click-aliases";
      version = "1.0.1";

      src = fetchPypi{
        inherit version;
        inherit pname;
        sha256 = "18q5wya46mdlm2g8x6bcxhzqf09nxy7lbvpqyh1fp207gq3i507l";
      };

      buildInputs = [ click ];
  };
  pythonPkgs = python-packages: with python-packages; [
      ptpython # used for dev
      markdown-table # for building docs
      pyyaml
      jsonschema
    ];
  dtcli = with pkgs; stdenv.mkDerivation rec {
    version = "1.1.1";
    name = "dtcli-${version}";
    src = fetchurl {
      url = "https://github.com/dynatrace-oss/dt-cli/releases/download/v${version}/dt";
      sha256 = "sha256-DJNNGB31SUODhlQYMFwv9CEf0Rm/kOmDdMqTj57p6PY=";
    };

    unpackPhase = ''
      true
    '';

    installPhase = ''
      install -m755 -D $src $out/bin/dt
    '';

    meta = with lib; {
      platforms = platforms.linux;
    };
  };
  commonMake = with pkgs; stdenv.mkDerivation rec {
    version = "7a34142faa0fc15b3c3d6653cb19bb825f9efe77";
    name = "commonMake-${version}";
    src = builtins.fetchGit {
      url = "https://github.com/dynatrace-extensions/toolz.git";
      ref = "main";
      rev = version;
    };

    # TODO: how to better merge it into the environment?
    installPhase = ''
      install -m755 -D common.mk $out/bin/__dt_ext_common_make
    '';

    meta = with lib; {
      platforms = platforms.linux;
    };
  };
  dtClusterSchema = with pkgs; stdenv.mkDerivation rec {
    version = "1-230";
    name = "dynatrace-cluster-schemas-${version}";
    src = fetchzip {
      url = "https://github.com/dynatrace-extensions/toolz/releases/download/schema-1230/dt-schemas-1-230.tar";
      sha256 = "sha256-9jc8HIZiTG9Qk/TULWNx9PAfi8M6Kq9k+7EWoJKgcHE=";
      stripRoot = false;
    };

    # TODO: how to better merge it into the environment?
    installPhase = ''
      mkdir -p $out/schemas
      cp * $out/schemas
      touch ble
      install -m755 -D ble $out/bin/__dt_cluster_schema
    '';
  };
  pythonCore = pkgs.python38;
  myPython = pythonCore.withPackages pythonPkgs;
  env = pkgs.buildEnv {
    name = "extension-dev-env";
    paths =
    with pkgs;
    [
      git
      gnugrep
      gnumake
      yq
      curl
      jq
      myPython
      entr
      commonMake

      bzip2
      openssl
      zip

      dtcli
      dtClusterSchema

      # datasources
      # temporary disabled, until we figure out how to share it properly
      #snmpDatasource

      # extension-specific
      net-snmp
    ];
  };
in
{
  shell = pkgs.mkShell {
    buildInputs = [ env ];
  };
}
