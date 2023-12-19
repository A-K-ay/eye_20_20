//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_desktop_sleep/flutter_desktop_sleep_plugin_c_api.h>
#include <windows_notification/windows_notification_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterDesktopSleepPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterDesktopSleepPluginCApi"));
  WindowsNotificationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowsNotificationPluginCApi"));
}
