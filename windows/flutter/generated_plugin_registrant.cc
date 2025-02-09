//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <flutter_doc_scanner/flutter_doc_scanner_plugin_c_api.h>
#include <flutter_timezone/flutter_timezone_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  FlutterDocScannerPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterDocScannerPluginCApi"));
  FlutterTimezonePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterTimezonePluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
