// This file should be placed in the Firefox installation directory
// (folder) with the with the name:
//  disable-add-on-signing.js
// Windows: <Install directory>\disable-add-on-signing.js
try {
    Components.utils.import("resource://gre/modules/addons/XPIProvider.jsm", {})
              .eval("SIGNED_TYPES.clear()");
} catch(ex) {}
try {
    Components.utils.import("resource://gre/modules/addons/XPIInstall.jsm", {})
              .eval("SIGNED_TYPES.clear()");
} catch(ex) {}
