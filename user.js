/******************************************************************************
 *  AppContainer (LPAC) for Firefox - user.js                                 *
 *                                                                            *
 *  The purpose here is to disable settings which can spawn additional        *
 *  firefox.exe processes which would cause the sandbox to crash.             *
 ******************************************************************************/

// Set Downloads Directory
user_pref("browser.download.dir", "C:\\AppContainer\\Downloads");
// Disable Default Browser Check
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.shell.defaultBrowserCheckCount", 1);
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
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
// EME Free
user_pref("media.eme.enabled", false);
// Firefox 118+: Disable Utility process for Oracle JavaScript
user_pref("browser.opaqueResponseBlocking.javascriptValidator", false);
// Disable Picture-in-Picture to avoid crash
user_pref("media.videocontrols.picture-in-picture.enabled", false);
// Private Window Separation
user_pref("browser.privateWindowSeparation.enabled", false);
// Disable Browser Translations (due to crash)
user_pref("browser.translations.automaticallyPopup", false);
user_pref("browser.translations.enable", false);
user_pref("browser.translations.panelShown", false);
// more
user_pref("browser.tabs.remote.separatePrivilegedContentProcess", false);
user_pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false);
user_pref("dom.ipc.keepProcessesAlive.privilegedabout", 0);
user_pref("dom.ipc.processCount.privilegedabout", 0);
user_pref("dom.ipc.processCount.privilegedmozilla", 0);
// Fix Cloudflare Turnstile crashes
user_pref("browser.tabs.remote.useCrossOriginOpenerPolicy", false);
