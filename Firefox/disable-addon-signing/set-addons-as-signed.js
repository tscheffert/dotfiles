// Script to enable addons disabled by signing errors
// Source: https://stackoverflow.com/a/55990005/2675529

// Set this in about:config if necessary
// # Command line in browser console
// devtools.chrome.enabled;true

// For FF < v57 >...?
async function set_addons_as_signed() {
  Components.utils.import("resource://gre/modules/addons/XPIProvider.jsm");
  Components.utils.import("resource://gre/modules/AddonManager.jsm");
  let XPIDatabase = this.XPIInternal.XPIDatabase;

  let addons = await XPIDatabase.getAddonList(a => true);

  for (let addon of addons) {
    // The add-on might have vanished, we'll catch that on the next startup
    if (!addon._sourceBundle.exists())
      continue;

    if( addon.signedState != AddonManager.SIGNEDSTATE_UNKNOWN )
      continue;

    addon.signedState = AddonManager.SIGNEDSTATE_NOT_REQUIRED;
    AddonManagerPrivate.callAddonListeners("onPropertyChanged",
      addon.wrapper,
      ["signedState"]);

    await XPIProvider.updateAddonDisabledState(addon);

  }
  XPIDatabase.saveChanges();
}

set_addons_as_signed();
