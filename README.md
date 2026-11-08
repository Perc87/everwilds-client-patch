# EverWilds client patch

Version history for the EverWilds RoF2 player client patch.

## Download

[Download the ready-to-install Client Files.zip](Client%20Files.zip?raw=true). This is the unchanged original archive, including the installer, core patch and icons.

## Install

1. Close all EverQuest clients.
2. Extract the full patch ZIP.
3. Place the entire EverWilds-Client-Patch folder inside your RoF2 client folder, beside eqgame.exe.
4. Open the patch folder and run Install EverWilds.bat.
5. Use the Default UI and restart the client after installation.

The installer backs up replaced files and checks their hashes. Keep the Client subfolder and all support files together. See [README.txt](README.txt) for feature details and custom-skin guidance.

## Repository layout

- Client/: patch payload, preserving paths relative to the RoF2 client.
- Install EverWilds.bat and Install-EverWilds.ps1: installer.
- SHA256SUMS.txt and release.json: original integrity metadata.

The initial files were imported byte-for-byte from Client Files.zip (SHA256 7ecc3d3c7e5d3ff8737351fa4b5e996f22fbb2b58be1822be1ed1863fcc16d7d). The ZIP contains 130 client payload files and five support files.

This repository does not contain a complete game client. Keep your existing RoF2 assets and personal settings.
