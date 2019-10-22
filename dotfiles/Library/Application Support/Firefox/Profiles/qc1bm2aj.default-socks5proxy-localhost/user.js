/******************************************************************************
 * about:preferences                                                          *
 ******************************************************************************/

// General > Always check if Firefox is your default browser: False
user_pref("browser.shell.checkDefaultBrowser", false);

// General > Ctrl+Tab cycles through tabs in recently used order: False
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// General > Allow Firefox to: Check for updates but let you choose to install
// them
user_pref("app.update.auto", false);

// General > Recommend extensions as you browser: False
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);

// General > Recommend features as you browser: False
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// General > Network Settings > Manual proxy configuration: True
user_pref("network.proxy.type", 1);

// General > Network Settings > SOCKS Host: localhost, Port: 58585
user_pref("network.proxy.socks", "localhost");
user_pref("network.proxy.socks_port", 58585);

// Home > Homepage and new windows: Blank Page
user_pref("browser.startup.homepage", "about:blank");

// Home > New tabs: Blank Page
user_pref("browser.newtabpage.enabled", false);

// Search > Default Search Engine: DuckDuckGo
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");

// Privacy > Enhanced Tracking Protection: Strict
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Privacy > Clear History > Time range to clear: Everything
user_pref("privacy.sanitize.timeSpan", 0);

// Privacy > Allow Firefox to send technical and interaction data to Mozilla: False
user_pref("datareporting.healthreport.uploadEnabled", false);

// Privacy > Allow Firefox to install and run studies: False
user_pref("app.shield.optoutstudies.enabled", false);

// Privacy > Clear history when Firefox closes > Settings > Browsing History:
// False
user_pref("privacy.clearOnShutdown.history", false);


/******************************************************************************
 * about:config                                                               *
 ******************************************************************************/

// Disable Pocket
// https://support.mozilla.org/en-US/kb/disable-or-re-enable-pocket-for-firefox
user_pref("extensions.pocket.enabled", false);
