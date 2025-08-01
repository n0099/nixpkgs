{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "topfew-rs";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "djc";
    repo = "topfew-rs";
    rev = version;
    hash = "sha256-VlSLPcKw3LYGnmKk5YOkcGIizw1tqtKF2BykY+1MtvY=";
  };

  cargoHash = "sha256-NAM/s3m+ZqgHoX6GESgJOxr88sy4+JieWB8u8aKbW7Y=";

  meta = with lib; {
    description = "Rust implementation of Tim Bray's topfew tool";
    homepage = "https://github.com/djc/topfew-rs";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "tf";
  };
}
