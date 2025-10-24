{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "webots";
  version = "2025a";

  src = fetchurl {
    url = "https://github.com/cyberbotics/webots/releases/download/R${version}/webots-R${version}-x86-64.tar.bz2";
    sha256 = "0f4cyckg4fg1jn2y16kdjb40nrwbvbrvgw93anpaamvc42s7y4n5";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    python3
    openjdk
    libGL
    libGLU
    glib
    # freeimage - removed due to security issues, webots bundles its own
    freetype
    libxml2
    libzip
    boost
    gd
    readline
    libusb1
    libpulseaudio
    openal
    alsa-lib
    libssh
    zlib
    libuuid
    cups
    dbus
    libdrm
    mesa
    nspr
    nss
    expat
    fontconfig
    libxkbcommon
    pango
    cairo
    gdk-pixbuf
    gtk3
    at-spi2-atk
    at-spi2-core
    sndio
    openexr_3
    
    # X11 libraries
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXt
    xorg.libXtst
    xorg.libXi
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libxcb
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXScrnSaver
    xorg.libSM
    xorg.libICE
    xorg.xcbutil
    xorg.xcbutilimage
  ];

  dontBuild = true;
  dontConfigure = true;

  # Ignore missing Qt6 wayland plugin - it's optional
  autoPatchelfIgnoreMissingDeps = [
    "libQt6WlShellIntegration.so.6"
    "libImath-2_5.so.25"      # Old version bundled with Webots
    "libgcrypt.so.20"          # Old version bundled with Webots
    "libgpg-error.so.0"        # Old version bundled with Webots
    # Ignore missing libraries that are bundled with Webots or optional
  ];

  unpackPhase = ''
    tar xjf $src
    cd webots
  '';

  installPhase = ''
    runHook preInstall

    # Create installation directories
    mkdir -p $out/{bin,share/webots,share/applications,share/icons/hicolor}
    
    # Copy all Webots files
    cp -r * $out/share/webots/
    
    # Create wrapper for the main executable
    makeWrapper $out/share/webots/webots $out/bin/webots \
      --prefix PATH : ${lib.makeBinPath [ python3 openjdk ]} \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}:$out/share/webots/lib/webots \
      --set WEBOTS_HOME $out/share/webots \
      --set JAVA_HOME ${openjdk}/lib/openjdk \
      --set QT_XKB_CONFIG_ROOT ${xorg.xkeyboardconfig}/etc/X11/xkb

    # Create wrappers for other executables
    for binary in webots-bin webots-controller webots-project; do
      if [ -f $out/share/webots/$binary ]; then
        makeWrapper $out/share/webots/$binary $out/bin/$binary \
          --prefix PATH : ${lib.makeBinPath [ python3 openjdk ]} \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}:$out/share/webots/lib/webots \
          --set WEBOTS_HOME $out/share/webots
      fi
    done

    # Install desktop file
    cat > $out/share/applications/webots.desktop << EOF
[Desktop Entry]
Version=1.0
Name=Webots
GenericName=Mobile Robot Simulation
Comment=Simulate, program and transfer your robot
Exec=$out/bin/webots %f
Icon=webots
Terminal=false
Type=Application
Categories=Development;Science;Education;Robotics;
MimeType=application/x-webots-world;
Keywords=robot;simulation;3d;
EOF

    # Copy icons
    if [ -d $out/share/webots/resources/icons ]; then
      for size in 16 24 32 48 64 128 256; do
        if [ -f $out/share/webots/resources/icons/core/webots-$size.png ]; then
          mkdir -p $out/share/icons/hicolor/''${size}x''${size}/apps
          cp $out/share/webots/resources/icons/core/webots-$size.png \
             $out/share/icons/hicolor/''${size}x''${size}/apps/webots.png
        fi
      done
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Open-source 3D robot simulator";
    longDescription = ''
      Webots is an open-source robot simulator that provides a complete development
      environment to model, program and simulate robots, vehicles and mechanical systems.
      
      It has been designed for a professional use and is widely used in industry, 
      education and research. Webots includes a large collection of freely modifiable 
      models of robots, sensors, actuators and objects.
    '';
    homepage = "https://cyberbotics.com";
    downloadPage = "https://github.com/cyberbotics/webots/releases";
    changelog = "https://github.com/cyberbotics/webots/blob/master/docs/reference/changelog-r${version}.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "webots";
  };
}