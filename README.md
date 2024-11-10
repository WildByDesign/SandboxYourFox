# Sandbox Your Fox
## Less Privileged AppContainer (LPAC) Sandbox for Firefox
### _AppContainer Isolation | Faster Firefox | Secure Firefox_

### Recent Changes in 130.0.0+:

- Custom-made Installer and Uninstaller for easy testing and smooth upgrades
- Firefox Process Mitigations are set with the installer
- Changed directories for binaries and profile for better ACL management:
  - Binaries are installed to: `%PROGRAMFILES%\SandboxYourFox`
  - Profile directory: `%LOCALAPPDATA%\Packages\appcontainer.launcher\AC\Profile`
  - Downloads directory: `%LOCALAPPDATA%\Packages\appcontainer.launcher\AC\Downloads`
- Submitted a [patch](https://phabricator.services.mozilla.com/D218999) upstream to make future builds easier
- Switched from [wsudo](https://github.com/M2Team/Privexec/tree/master/wsudo) to Microsoft's [LaunchAppContainer](https://github.com/microsoft/SandboxSecurityTools)
- Fixed a crash on the `about:support` page
- ACLs are set which give permission specifically to container `appcontainer.launcher` for:
  - `%APPDATA%\Mozilla`
  - `%LOCALAPPDATA%\Mozilla`
  - `HKEY_CURRENT_USER\Software\Mozilla`
- Added SetAppContainerACL program for setting file system and registry ACL permissions

### Summary:

This runs Firefox within an AppContainer (LPAC) with it's own profile that is contained separately from any other Firefox profile that you may already have. Therefore, you can play around with this and test it without affecting your regular Firefox installation or your regular profile.

### What You Get:

- Firefox running in a secure AppContainer _(LPAC)_ sandbox
- Firefox running in single process mode _(E10s/Fission disabled)_
- Firefox running in Private Browsing Mode
- Firefox EME-free (no DRM)


### What You Don't Get:

- No updates except from here (since `MOZ_FORCE_DISABLE_E10S` requires `MOZILLA_OFFICIAL` to not be set, meaning has to be unofficial build)
- Regular browsing mode crashes due to Shared Web Content process ([workaround](https://github.com/WildByDesign/SandboxYourFox?tab=readme-ov-file#regular-browsing-mode))
- DRM components fail _(no Netflix, Disney Plus, etc.)_
- Firefox Sync does not work
- Picture-in-Picture Mode (causes Firefox to crash)
- Built-in Translations feature (causes Firefox to crash)

### How To Install:

Simply run the installer from the latest release. It will take care of everything needed.


### How To Upgrade:

You don't need to uninstall before upgrading. Just run the latest installer. It will remove the older release files and install the newer version.


### How To Uninstall:

Run the uninstaller directly from: `%PROGRAMFILES%\SandboxYourFox\Uninstall.exe`

The uninstaller will first ask if you want to uninstall SandboxYourFox program files. Then it will ask if you want to remove your Profile as well. This gives the opportunity to keep your Profile when uninstalling just in case it is still needed later.


### Why Aren't The Firefox Binaries Digitally Signed?:

SandboxYourFox uses the `MOZ_FORCE_DISABLE_E10S` environment variable to enable single-process mode which is necessary to run in an AppContainer (without major changes within Firefox code). `MOZ_FORCE_DISABLE_E10S` worked for many years in official builds. But recently, Firefox developers made it so that builds with `MOZILLA_OFFICIAL` set would no longer work with `MOZ_FORCE_DISABLE_E10S`. For `MOZ_FORCE_DISABLE_E10S` to work, the new requirement basically requires a non-official build and therefore no longer works with official Firefox builds. No changes to the actual Firefox source code were required.


### SetAppContainerACL:

SetAppContainerACL program is located `%PROGRAMFILES%\SandboxYourFox\SetAppContainerACL.exe`.

This will set ACL permissions specifically (and only) for `AppContainer.Launcher` which is associated with the following SID:
`S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996`

You may decide that you need Firefox to access other files, directories or registry keys which are not accessible to LPAC processes by default. That is what this tool is for.

Usage Examples:
```
C:\Example
C:\Example\Example.txt
C:\Program Files\Example
Registry::CURRENT_USER\Software\Example
Registry::LOCAL_MACHINE\SOFTWARE\Example
```
Important:

Please remember that setting ACL permissions on certain directories (eg. `C:\Program Files` and `C:\Windows`) and registry keys (eg. `HKEY_LOCAL_MACHINE`) require running SetAppContainerACL as Admin.


### Regular Browsing Mode:

Regular browsing mode (caching, history, cookies, etc.) for the first several years of this project had always crashed. This was due to a Shared Web Content process that was started even with Fission disabled.

Recently, I have discovered that there is a way to use regular browsing mode with SandboxYourFox that remembers your browsing session to session. SandboxYourFox absolutely must be started in Private Browsing mode to avoid the Shared Web Content process. From there, you can open a regular New tab (`New window`) and this will deal with your sessions (caching, history, cookies, etc.) as per normal and no Shared Web Content process is started using this method.


### Policies.7z

Contains: 
- `distribution.ini` which sets EME-free mode
- `policies.json` which disables updates and sets Downloads directory
- `channel-prefs.js` which sets the update channel (updates not used anyway)
- `syspref.js` which contains most prefs that SandboxYourFox needs to function
