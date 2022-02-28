# DBeaver portable client updater
Scripts to automatically download and update the DBeaver portable client (Win64 ZIP)

## Prerequisites
Please install [7-Zip](https://www.7-zip.org) from Igor Pavlov.

## Installation
Copy the files ([Update.bat](Update.bat) & [Update.ps1](Update.ps1)) to the root folder of DBeaver next to **dbeaver.exe**
Configure the 7-Zip location in the Update.bat second line if necessary: `SET ZIP_PATH=C:\Program Files\7-Zip\`

## Usage
When DBeaver notifies you about a client update, while it is not running just execute the **Update.bat**
If there is a newer DBeaver for Windows client is available it downloads and updates the necessary client files:
```
Current client is:
version=21.3.4

Downloading DBeaver Windows 64 bit (zip)...
Download completed!

Extracting archive: .update\dbeaver-ce-latest-win32.win32.x86_64.zip

New client is:
version=21.3.5


Waiting for 20 seconds, press a key to continue ...
```
If your client is up-to-date it skips the update process:
```
Current client is:
version=21.3.5

Downloading DBeaver Windows 64 bit (zip)...
Download skipped!

Current client is up to date


Waiting for 25 seconds, press a key to continue ...
```
After that you can start **dbeaver.exe** as before.

## ChangeLog
See the [Change Log](CHANGELOG.md) for recent changes.
