//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <address_search_field/address_search_field_plugin.h>
#include <connectivity_plus_windows/connectivity_plus_windows_plugin.h>
#include <firebase_core/firebase_core_plugin_c_api.h>
#include <geolocator_windows/geolocator_windows.h>
#include <smart_auth/smart_auth_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AddressSearchFieldPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AddressSearchFieldPlugin"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
  SmartAuthPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SmartAuthPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
}
