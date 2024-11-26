
{ lib, stdenvnocc, fetchzip }:

stdenvnocc.mkDerivation {
  pname = "lora-font";
  version = "3.005";

  src = fetchzip {
    url = "https://github.com/georgd/EB-Garamond/releases/download/nightly/EBGaramond.zip";
    stripRoot = false;
    hash = "sha256-IuHbUrtLP9RpcXKAigaaex6jNv6LPopfYtQ+3isD0DI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts"
    mkdir -p "$out/share/fonts/opentype"
    mkdir -p "$out/share/fonts/truetype"

    mv *.otf "$out/share/fonts/opentype/"
    mv *.ttf "$out/share/fonts/truetype/"

    runHook postInstall
  '';

  meta = with lib; {
    description = ''
      This project aims at providing a free version of the Garamond types, based on the Designs of the Berner specimen from 1592.
    '';
    homepage = "https://github.com/georgd/EB-Garamond";
    license = licenses.ofl;
    maintainers = with maintainers; [ abhi-xyz ];
    platforms = platforms.all;
  };
}

