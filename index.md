# Sandbox Your Fox
## Less Privileged AppContainer (LPAC) Sandbox for Firefox
### _Pure AppContainer | No AppSilo | Faster Firefox | Zero Calories_

![Sandbox Your Fox](https://raw.githubusercontent.com/WildByDesign/SandboxYourFox/main/SandboxYourFox.png)

### What You Get:

- Firefox running in a secure AppContainer _(LPAC)_ sandbox
- Firefox running in single process mode _(E10s/Fission disabled)_
- Firefox running in Private Browsing Mode


### What You Don't Get:

- Updates fail and must be done outside of AppContainer
- Regular browsing mode crashes due to Shared Web Content process
- DRM components fail _(no Netflix, Disney Plus, etc.)_
- Firefox Sync does not work


### Requirements:

- You absolutely must set ACL permimssions first _(see ACL section below)_
- The `user.js` file in profile will copy important settings to `prefs.js` on first start _(see user.js section below)_


### ACLs:

```
C:\AppContainer
C:\Users\{your-user-name}\AppData\Local\Mozilla
C:\Users\{your-user-name}\AppData\LocalLow\Mozilla
C:\Users\{your-user-name}\AppData\Roaming\Mozilla
```
_* replace {your-user-name} with the username and directory structure on your system_

Add steps to set ACLs

Add screenshot as well

### user.js:

The `user.js` file is included in `C:\AppContainer\Firefox\profile` which is critical because the Firefox AppContainer will crash without these settings. I copied the `user.js` below for descriptive purposes.

```javascript
/******************************************************************************
 *  AppContainer (LPAC) for Firefox - user.js                                 *
 *                                                                            *
 *  The purpose here is to disable settings which can spawn additional        *
 *  firefox.exe processes which would cause the sandbox to crash.             *
 ******************************************************************************/

// Set Downloads Directory
user_pref("browser.download.dir", "C:\\AppContainer\\Downloads");
// Disable Launcher Process
user_pref("browser.launcherProcess.enabled", false);
// Disable New Process
user_pref("dom.noopener.newprocess.enabled", false);
// Disable VR Process
user_pref("dom.vr.process.enabled", false);
// Disable geo-location as it spawns WindowsUtils utility process
user_pref("geo.provider.ms-windows-location", false);
// Disable GPU Process
user_pref("layers.gpu-process.enabled", false);
// Disable Media RDD Process
user_pref("media.rdd-process.enabled", false);
// Disable Media Utility Process
user_pref("media.utility-process.enabled", false);
// Disable Network Process
user_pref("network.process.enabled", false);

```
