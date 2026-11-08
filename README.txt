EverWilds â€” RoF2 Client Patch

Close EverQuest first.

1. Put the entire EverWilds-Client-Patch folder inside your RoF2 client folder,
   next to eqgame.exe.
2. Open that patch folder and double-click Install EverWilds.bat.

The installer finds the client automatically, backs up replaced files and checks
the installed files. When it says installation succeeded, launch normally.
Use the Default UI. Leave the Client subfolder inside the patch folder.
If you downloaded the ZIP, extract it first; do not run the BAT inside the ZIP.

This patch contains the current EverWilds Dinput8 DLL, spell definitions,
ability descriptions, Advanced Loot and Aetherkin Vault windows, and the
CSHome default character creation/selection UI and class-name strings, and bank item search. The DLL also contains the custom
Order combat display and five-second camp countdown changes.

The installer also applies syn_chr.s3d, which fixes the capture ghost model's
missing overhead-name attachment.

Resources/GlobalLoad.txt and Resources/GlobalLoad_chr.txt match the working
EverWilds client and enable its global model loading. The installer copies
both into Resources and backs up any existing versions. Restart the client
after installing so it reloads the model lists. Keep all original RoF2 assets.
freeporttemple_chr.txt imports the verified actor archives for the Temple model gallery.

The Default UI item-icon sheets now include every art-backed icon listed by
Spire, including the Aetherkin Vaultstone icon. Keep EQUI_Animations.xml and
all supplied EW_dragitem DDS files together. Fully close RoF2 before installing
and use the Default UI so the expanded icon animation is loaded.

The character creation race/class purchase badges are transparent on EverWilds;
normal enabled/disabled selection states and supported combinations are unchanged.

The Default bank window includes a name search for personal/shared bank items
and their bag contents. Results show quantity and bank/bag slot. This feature
requires the supplied DLL and bank window XML files (EQUI_BankWnd.xml and
EQUI_BigBankWnd.xml). The 24-slot bank uses BigBankWnd. Clear the search to show all.
Select a result and press Withdraw to move it to your empty cursor using normal
banking. A changed item or occupied cursor prevents the withdrawal.

For custom skins, back up your skin and merge the two custom window includes
and their matching XML files into that skin's EQUI.xml. Do not overwrite a
custom skin's EQUI.xml with the Default version supplied here. Custom skin
compatibility requires separate testing.

This is a patch for the supported RoF2 client, not a complete game client.
Includes 89 approved custom Aetherball and Resonator icons (IDs 10796-10884) on
new pages 287-289. Restart the client after installing the icon update.
Keep all existing game assets. No personal settings are supplied or required.
SHA256SUMS.txt lists the exact payload files for integrity checking.
