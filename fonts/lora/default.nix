
{ lib, stdenvnocc, fetchzip }:

stdenvnocc.mkDerivation {
  pname = "lora-font";
  version = "3.005";

  src = fetchzip {
    url = "https://github.com/cyrealtype/lora-cyrillic/releases/download/v3.005/lora-v3.005.zip";
    stripRoot = false;
    hash = "sha256-K4mCusuzrqZgY+Xs1zWALSNuXUGF2plHbfGV99g2UGQ=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts"

    # Ensure these directories exist in the source
    mv fonts/otf "$out/share/fonts/opentype"
    mv fonts/ttf "$out/share/fonts/truetype"
    mv fonts/variable "$out/share/fonts/variable"
    mv fonts/webfonts "$out/share/fonts/woff2"

    runHook postInstall
  '';

  meta = with lib; {
    description = ''
      Lora is a well-balanced contemporary serif with roots in calligraphy. 
      It is a text typeface with moderate contrast, well-suited for body text. 
      A paragraph set in Lora will make a memorable appearance because of its 
      brushed curves in contrast with driving serifs. 
      The overall typographic voice of Lora perfectly conveys the mood of a 
      modern-day story or an art essay.
    '';
    homepage = "https://github.com/cyrealtype/lora-cyrillic";
    license = licenses.ofl;
    maintainers = with maintainers; [ abhi-xyz ];
    platforms = platforms.all;
  };
}

