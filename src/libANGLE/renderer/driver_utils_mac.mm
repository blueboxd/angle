//
// Copyright 2019 The ANGLE Project Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//

// driver_utils_mac.mm : provides mac-specific information about current driver.

#include "libANGLE/renderer/driver_utils.h"

#import <Foundation/Foundation.h>

namespace rx
{

#if defined(ANGLE_PLATFORM_MACOS)
OSVersion GetMacOSVersion()
{
    OSVersion result;
    if (@available(macOS 10.10, *)) {
      NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
      result.majorVersion              = static_cast<int>(version.majorVersion);
      result.minorVersion              = static_cast<int>(version.minorVersion);
      result.patchVersion              = static_cast<int>(version.patchVersion);
    } else {
      extern OSErr Gestalt(OSType selector, SInt32 *response) __attribute__((weak_import, weak));
      ::Gestalt(gestaltSystemVersionMajor, reinterpret_cast<SInt32*>(&result.majorVersion));
      ::Gestalt(gestaltSystemVersionMinor, reinterpret_cast<SInt32*>(&result.minorVersion));
      ::Gestalt(gestaltSystemVersionBugFix, reinterpret_cast<SInt32*>(&result.patchVersion));
    }
    return result;
}
#endif
}
