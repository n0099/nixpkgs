{
  lib,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
  stdenv,
}:

rustPlatform.buildRustPackage rec {
  pname = "krill";
  version = "0.14.6";

  src = fetchFromGitHub {
    owner = "NLnetLabs";
    repo = "krill";
    rev = "v${version}";
    hash = "sha256-U7uanUE/xdmXqtpvnG6b+oDKamNZkCH04OCy3Y5UIhQ=";
  };

  cargoHash = "sha256-PR8HoHroHp5nBbRwR8TZ5NeBH4eDXGV46HkDLeydmAk=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  # Needed to get openssl-sys to use pkgconfig.
  OPENSSL_NO_VENDOR = 1;

  # disable failing tests on darwin
  doCheck = !stdenv.hostPlatform.isDarwin;

  meta = {
    description = "RPKI Certificate Authority and Publication Server written in Rust";
    longDescription = ''
      Krill is a free, open source RPKI Certificate Authority that lets you run
      delegated RPKI under one or multiple Regional Internet Registries (RIRs).
      Through its built-in publication server, Krill can publish Route Origin
      Authorisations (ROAs) on your own servers or with a third party.
    '';
    homepage = "https://github.com/NLnetLabs/krill";
    changelog = "https://github.com/NLnetLabs/krill/releases/tag/v${version}";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ steamwalker ];
  };
}
