#Vars
$FireFoxFolder = $env:APPDATA + '\Mozilla\Firefox\Profiles'
$ThunderBirdFolder = $env:APPDATA + \Thunderbird\Profiles'
$KleopartraGNUPGFolder = $env:APPDATA + '\gnupg'

New-Item -Path $env:USERPROFILE -Name ('backup') -ItemType "directory"

$BackupFolder = $env:USERPROFILE + 'backup'

#Show Folder Size
$FireFoxFolderSize = $FireFoxFolder + " " + "->" + " " + ((Get-ChildItem $FireFoxFolder -Recurse | Measure-Object -Property length -Sum).Sum)/1mb + " " + "MB"
$ThunderBirdFolderSize =$ThunderBirdFolder + " " + "->" + " " + ((Get-ChildItem $ThunderBirdFolder -Recurse | Measure-Object -Property length -Sum).Sum)/1mb + " " + "MB"
$KleopartraGNUPGFolderSize =$KleopartraGNUPGFolder + " " + "->" + " " + ((Get-ChildItem $KleopartraGNUPGFolder -Recurse | Measure-Object -Property length -Sum).Sum)/1mb + " " + "MB"

#Stop FF
$firefox = Get-Process -Name "Firefox" -ErrorAction SilentlyContinue
if ($firefox) {
  # try gracefully first
  $firefox.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$firefox.HasExited) {
    $firefox | Stop-Process -Force
  }
}
Remove-Variable firefox
#Stop TB
$thunderbird = Get-Process -Name "ThunderBird" -ErrorAction SilentlyContinue
if ($thunderbird ) {
  # try gracefully first
  $thunderbird.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$thunderbird.HasExited) {
    $thunderbird | Stop-Process -Force
  }
}
Remove-Variable thunderbird

#Stop gnupg
$gnupg = Get-Process -Name "gnupg" -ErrorAction SilentlyContinue
if ($gnupg ) {
  # try gracefully first
  $gnupg.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$gnupg.HasExited) {
    $gnupg | Stop-Process -Force
  }
}
Remove-Variable gnupg

#Stop Kleo
$kleopatra = Get-Process -Name "Kleopatra" -ErrorAction SilentlyContinue
if ($kleopatra ) {
  # try gracefully first
  $kleopatra.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$kleopatra.HasExited) {
    $kleopatra | Stop-Process -Force
  }
}
Remove-Variable kleopatra


#Start
Write-Host -ForegroundColor Yellow "START"
Write-Host -ForegroundColor Green $FireFoxFolderSize
Write-Host -ForegroundColor Green $ThunderBirdFolderSize
Write-Host -ForegroundColor Green $KleopartraGNUPGFolderSize

Write-Host -ForegroundColor Yellow "1." #small debug shit
#Backup Firefox Profile
Copy-Item -Path $FireFoxFolder -Destination ($BackupFolder + "\FirefoxBackup") -Recurse
Write-Host -ForegroundColor Yellow "2."
#BackUp ThunderBird
Copy-Item -Path $ThunderBirdFolder -Destination ($BackupFolder + "\ThunderbirdBackup") -Recurse
Write-Host -ForegroundColor Yellow "3."
#BackUp Kleopatra
Copy-Item -Path $KleopartraGNUPGFolder -Destination ($BackupFolder + "\KleopatraBackup") -Recurse
Write-Host -ForegroundColor Yellow "4."
#BackUp Putty All Settings#
New-Item -Path $BackupFolder -Name "PuttyBackup" -ItemType "directory"
reg export HKCU\Software\SimonTatham ($BackupFolder + "\PuttyBackup\putty.reg")
