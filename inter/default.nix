{
  lib,
  stdenvnocc,
  fetchzip,
}:
stdenvnocc.mkDerivation rec {
  pname = "Inter";
  version = "4.1";

  src = fetchzip {
    url = "https://github.com/rsms/inter/releases/download/v4.1/${pname}-${version}.zip";
    stripRoot = false;
    hash = "sha256-5vdKKvHAeZi6igrfpbOdhZlDX2/5+UvzlnCQV6DdqoQ=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts"

    mv extras/otf "$out/share/fonts/opentype"
    mv extras/ttf "$out/share/fonts/truetype"
    mv extras/woff-hinted "$out/share/fonts/woff2"
    # mv web "$out/share/fonts/web"

    runHook postInstall
  '';

  meta = with lib; {
    description = ''
      Inter is a typeface carefully crafted & designed for computer screens. Inter features a tall x-height to aid in readability of mixed-case and lower-case text. Inter is a variable font with several OpenType features, like contextual alternates that adjusts punctuation depending on the shape of surrounding glyphs, slashed zero for when you need to disambiguate "0" from "o", tabular numbers, etc.
    '';
    homepage = "https://github.com/rsms/inter";
    license = licenses.ofl;
    maintainers = with maintainers; [abhi-xyz];
    platforms = platforms.all;
  };
}
