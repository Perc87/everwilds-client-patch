param([switch]$ValidateOnly)
$ErrorActionPreference='Stop'
try {
 $package=$PSScriptRoot
 $files=@('dinput8.dll','spells_us.txt','dbstr_us.txt','eqstr_us.txt','syn_chr.s3d',
 'Resources/GlobalLoad.txt','Resources/GlobalLoad_chr.txt',
 'freeporttemple_chr.txt',
 'uifiles/default/EQUI.xml','uifiles/default/EQUI_AdvLootWnd.xml',
 'uifiles/default/EQUI_AetherkinVaultWnd.xml','uifiles/default/EQUI_BankWnd.xml',
 'uifiles/default/EQUI_BigBankWnd.xml','uifiles/default/EQUI_CharacterCreate.xml',
 'uifiles/default/EW_TransparentRaceClassOverlay.tga',
 'uifiles/default/EQUI_CharacterListWnd.xml',
 'uifiles/default/EQUI_CombatSkillsSelectWindow.xml')
 # Separate fixed allowlists: routine patches must never overwrite icon assets.
 $icons=@('uifiles/default/EQUI_Animations.xml')
 foreach($page in 178..289){$icons += ('uifiles/default/EW_dragitem'+$page+'.dds')}
 $manifest=Get-Content -LiteralPath (Join-Path $package 'release.json') -Raw | ConvertFrom-Json
 switch($manifest.package_kind){
  'core' { }
  'icons' {$files=$icons}
  'full' {$files += $icons}
  default {throw 'Unknown package type. Download a fresh EverWilds patch.'}
 }
 $listed=@($manifest.files.PSObject.Properties.Name)
 $expected=@($files | ForEach-Object {'Client/'+$_})
 if(@(Compare-Object ($listed|Sort-Object) ($expected|Sort-Object)).Count){throw 'Unexpected package contents. Download a fresh EverWilds patch.'}
 foreach($file in $files){
  $path=Join-Path $package ('Client/'+$file)
  if(!(Test-Path -LiteralPath $path -PathType Leaf)){throw "Missing package file: $file. Extract the entire ZIP first."}
  if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $manifest.files.('Client/'+$file)){throw "Package checksum failed: $file. Download and extract a fresh copy."}
 }
 if($ValidateOnly){Write-Host "All $($files.Count) client payload checksums verified.";exit 0}
 if(Get-Process -Name eqgame -ErrorAction SilentlyContinue){throw 'Close ALL EverQuest clients, then run the installer again.'}
 $Destination=Split-Path $package -Parent
 $Destination=[IO.Path]::GetFullPath($Destination).TrimEnd('\')
 if(!(Test-Path -LiteralPath (Join-Path $Destination 'eqgame.exe') -PathType Leaf)){throw 'Put this entire patch folder inside your EverQuest client folder, next to eqgame.exe, then run the BAT again.'}
 if($Destination -eq [IO.Path]::GetPathRoot($Destination).TrimEnd('\')){throw 'A drive root cannot be used as the client folder.'}
 # Reject junction/symlink destinations before touching any client files.
 foreach($file in $files){
  $check=Join-Path $Destination $file
  while($check -and $check.StartsWith($Destination,[StringComparison]::OrdinalIgnoreCase)){
   if(Test-Path -LiteralPath $check){$item=Get-Item -LiteralPath $check -Force;if($item.Attributes -band [IO.FileAttributes]::ReparsePoint){throw "Linked folders/files are not supported: $check"}}
   if($check -eq $Destination){break};$check=Split-Path $check -Parent
  }
 }
 $backup=Join-Path $Destination ('EverWilds-Patch-Backups/'+(Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
 New-Item -ItemType Directory -Path $backup -Force | Out-Null
 $original=@{};$written=New-Object 'System.Collections.Generic.List[string]'
 # Complete and verify every backup before replacing the first file.
 foreach($file in $files){
  $target=Join-Path $Destination $file
  $original[$file]=Test-Path -LiteralPath $target -PathType Leaf
  if($original[$file]){
   $saved=Join-Path $backup $file;New-Item -ItemType Directory -Path (Split-Path $saved) -Force | Out-Null
   Copy-Item -LiteralPath $target -Destination $saved
   if((Get-FileHash -LiteralPath $saved).Hash -ne (Get-FileHash -LiteralPath $target).Hash){throw "Backup verification failed: $file"}
  }
 }
 try {
  foreach($file in $files){
   $target=Join-Path $Destination $file
   New-Item -ItemType Directory -Path (Split-Path $target) -Force | Out-Null
   $written.Add($file)
   Copy-Item -LiteralPath (Join-Path $package ('Client/'+$file)) -Destination $target -Force
   if((Get-FileHash -LiteralPath $target).Hash -ne $manifest.files.('Client/'+$file)){throw "Installed checksum failed: $file"}
  }
 } catch {
  $failure=$_
  foreach($file in $written){
   $target=Join-Path $Destination $file
   if($original[$file]){Copy-Item -LiteralPath (Join-Path $backup $file) -Destination $target -Force}
   elseif(Test-Path -LiteralPath $target -PathType Leaf){Remove-Item -LiteralPath $target -Force}
  }
  throw "Installation failed and original files were restored. $failure"
 }
 $original | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $backup 'replaced-files.json') -Encoding UTF8
 Write-Host ''
 Write-Host 'EverWilds client patch installed successfully.' -ForegroundColor Green
 Write-Host "Verified all $($files.Count) installed files. Backup: $backup"
 Write-Host 'Use the Default UI. Your account settings and character INI files were not changed.'
 Write-Host 'Launch the game using your existing EverWilds launcher/shortcut.'
 exit 0
} catch {
 Write-Host $_.Exception.Message -ForegroundColor Red
 exit 1
}
