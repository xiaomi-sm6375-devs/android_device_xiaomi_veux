/*
 * Copyright (C) 2023 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "libnotifyaudiohal"

#include <android/hardware/audio/6.0/IDevicesFactory.h>
#include <log/log.h>
#include <string.h>

using android::sp;
using android::hardware::audio::V6_0::IDevicesFactory;
using android::hardware::audio::V6_0::IPrimaryDevice;
using android::hardware::audio::V6_0::Result;

void ultrasound_enable(int enable) {
    ALOGD("ultrasound_enable: %d", enable);
    auto factory = IDevicesFactory::getService();
    factory->openPrimaryDevice([&](Result retval, const sp<IPrimaryDevice>& result) {
        if (retval == Result::OK) {
            result->setParameters({} /* context */,
                                  {
                                          {"ultrasound-sensor", std::to_string(enable)},
                                  });
        }
    });
}

extern "C" void elliptic_notify_audio_hal(char* param) {
    ALOGD("elliptic_notify_audio_hal: %s", param);
    if (!strcmp(param, "ultrasound_enable=1")) {
        ultrasound_enable(1);
    } else if (!strcmp(param, "ultrasound_enable=0")) {
        ultrasound_enable(0);
    }
}

extern "C" void elliptic_ultrasound_supported() {
    return;
}
