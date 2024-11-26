{
  lib,
  stdenvnocc,
  fetchzip,
}:
stdenvnocc.mkDerivation {
  pname = "playfair_fonts";
  version = "2.203";

  src = fetchzip {
    url = "https://github.com/clauseggers/Playfair/releases/download/2.203/Playfair_2_203_fonts.zip";
    stripRoot = false;
    hash = "sha256-lVlyIwuMVrtup9FoxzY2t25Ea9SqH7jZLdvz88Yvyzg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts/truetype"
    mkdir -p "$out/share/fonts/woff2"

    # Ensure these directories exist in the source
    mv VF-TTF/*.ttf "$out/share/fonts/truetype/"
    mv VF-WOFF2/*.woff2 "$out/share/fonts/woff2/"

    runHook postInstall
  '';

  meta = with lib; {
    description = ''
    '';
    homepage = "https://github.com/clauseggers/Playfair";
    license = licenses.ofl;
    maintainers = with maintainers; [abhi-xyz];
    platforms = platforms.all;
  };
}
