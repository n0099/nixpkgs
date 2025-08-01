{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  curl,
  libevent,
  libsearpc,
  libuuid,
  pkg-config,
  python3,
  sqlite,
  vala,
  libwebsockets,
}:

stdenv.mkDerivation rec {
  pname = "seafile-shared";
  version = "9.0.8";

  src = fetchFromGitHub {
    owner = "haiwen";
    repo = "seafile";
    rev = "v${version}";
    sha256 = "sha256-IpRCgPxYy1El4EEvVEfzAlbxP/osQUb7pCP3/BhkecU=";
  };

  postPatch = ''
    substituteInPlace scripts/breakpad.py --replace-fail "from __future__ import print_function" ""
  '';

  nativeBuildInputs = [
    libwebsockets
    autoreconfHook
    vala
    pkg-config
    python3
    python3.pkgs.wrapPython
  ];

  buildInputs = [
    libuuid
    sqlite
    libsearpc
    libevent
    curl
  ];

  configureFlags = [
    "--disable-server"
    "--with-python3"
  ];

  pythonPath = with python3.pkgs; [
    pysearpc
  ];

  postFixup = ''
    wrapPythonPrograms
  '';

  meta = {
    homepage = "https://github.com/haiwen/seafile";
    description = "Shared components of Seafile: seafile-daemon, libseafile, libseafile python bindings, manuals, and icons";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [
      schmittlauch
    ];
  };
}
