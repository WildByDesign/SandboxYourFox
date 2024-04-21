/******************************************************************************
 *  AppContainer (LPAC) for Firefox - user.js                                 *
 *                                                                            *
 *  The purpose here is to disable settings which can spawn additional        *
 *  firefox.exe processes which would cause the sandbox to crash.             *
 ******************************************************************************/

// Set Downloads Directory
pref("browser.download.dir", "C:\\AppContainer\\Downloads", locked);
// Disable Default Browser Check
pref("browser.shell.checkDefaultBrowser", false, locked);
pref("browser.shell.defaultBrowserCheckCount", 1, locked);
pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true, locked);
// Disable Launcher Process
pref("browser.launcherProcess.enabled", false, locked);
// Disable New Process
pref("dom.noopener.newprocess.enabled", false, locked);
// Disable VR Process
pref("dom.vr.process.enabled", false, locked);
// Disable geo-location as it spawns WindowsUtils utility process
pref("geo.provider.ms-windows-location", false, locked);
// Disable GPU Process
pref("layers.gpu-process.enabled", false, locked);
// Disable Media RDD Process
pref("media.rdd-process.enabled", false, locked);
// Disable Media Utility Process
pref("media.utility-process.enabled", false, locked);
// Disable Network Process
pref("network.process.enabled", false, locked);
// EME Free
pref("media.eme.enabled", false, locked);
// Firefox 118+: Disable Utility process for Oracle JavaScript
pref("browser.opaqueResponseBlocking.javascriptValidator", false, locked);
// Disable Picture-in-Picture to avoid crash
pref("media.videocontrols.picture-in-picture.enabled", false, locked);
// Private Window Separation
pref("browser.privateWindowSeparation.enabled", false, locked);
// Disable Browser Translations (due to crash)
pref("browser.translations.automaticallyPopup", false, locked);
pref("browser.translations.enable", false, locked);
pref("browser.translations.panelShown", false, locked);
// more
pref("browser.tabs.remote.separatePrivilegedContentProcess", false, locked);
pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false, locked);
pref("dom.ipc.keepProcessesAlive.privilegedabout", 0, locked);
pref("dom.ipc.processCount.privilegedabout", 0, locked);
pref("dom.ipc.processCount.privilegedmozilla", 0, locked);
// Fix Cloudflare Turnstile crashes
pref("browser.tabs.remote.useCrossOriginOpenerPolicy", false, locked);
pref("browser.tabs.remote.useCrossOriginEmbedderPolicy", false, locked);
