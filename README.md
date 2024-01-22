# Sandbox Your Fox
## Less Privileged AppContainer (LPAC) Sandbox for Firefox
### _Pure AppContainer Isolation | No AppSilo | Faster Firefox | Secure Firefox | Portable Firefox_

<img src="https://raw.githubusercontent.com/WildByDesign/SandboxYourFox/main/SandboxYourFox.png" alt="Sandbox Your Fox">
* Yes, that is Process Explorer running in an AppContainer as well, showing only AppContainer processes.

### Summary:

This runs as a portable version of Firefox within an AppContainer (LPAC) with it's own profile. Therefore, you can play around with this and test it without affecting your regular Firefox installation or your regular profile.

### What You Get:

- Firefox running in a secure AppContainer _(LPAC)_ sandbox
- Firefox running in single process mode _(E10s/Fission disabled)_
- Firefox running in Private Browsing Mode
- Firefox EME-free (no DRM)


### What You Don't Get:

- Updates fail and must be done outside of AppContainer
- Regular browsing mode crashes due to Shared Web Content process
- DRM components fail _(no Netflix, Disney Plus, etc.)_
- Firefox Sync does not work
- Picture-in-Picture Mode (causes Firefox to crash)
- Built-in Translations feature (causes Firefox to crash)
- More troubleshooting information (about:support) crashes on 122


### Important Setup Instructions:

- Create the directory `C:\AppContainer`
- Extract the 7z archive from Releases into the `C:\AppContainer` directory
- Directory structure absolutely must be as follows:
```batch
C:\AppContainer
   ├───AppExec
   ├───Downloads
   └───Firefox
       ├───bin
       └───profile
```
- There is a `user.js` file in the `profile` folder which is absolutely critical for running as AppContainer
- Before first run, you must run `SetACLs.bat` to set the AppContainer ACLs _(you only need to do this once)_
- Now you can run Firefox in AppContainer by running `firefox.bat` or the included Firefox shortcut
