# Sandbox Your Fox
## Less Privileged AppContainer (LPAC) Sandbox for Firefox
### _AppContainer Isolation | Faster Firefox | Secure Firefox_

### Important Changes in 130.0.0 supersedes some info on this README:

- Custom-made Installer and Uninstaller for easy testing and smooth upgrades
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


### Regular Browsing Mode:

Regular browsing mode (caching, history, cookies, etc.) for the first several years of this project had always crashed. This was due to a Shared Web Content process that was started even with Fission disabled.

Recently, I have discovered that there is a way to use regular browsing mode with SandboxYourFox that remembers your browsing session to session. SandboxYourFox absolutely must be started in Private Browsing mode to avoid the Shared Web Content process. From there, you can open a regular New tab (`New window`) and this will deal with your sessions (caching, history, cookies, etc.) as per normal and no Shared Web Content process is started using this method.
