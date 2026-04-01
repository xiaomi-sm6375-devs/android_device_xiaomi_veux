#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/veux

# Inherit from sm6375-common
include device/xiaomi/sm6375-common/BoardConfigCommon.mk

# Audio
AUDIO_FEATURE_ELLIPTIC_ULTRASOUND_SUPPORT := true
AUDIO_FEATURE_ENABLED_EXT_AMPLIFIER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := veux

# HIDL
ODM_MANIFEST_FILES += \
    $(DEVICE_PATH)/manifest_odm.xml

ODM_MANIFEST_SKUS += \
    sn100

ODM_MANIFEST_SN100_FILES := \
    $(DEVICE_PATH)/manifest_ese.xml

# Kernel
TARGET_KERNEL_CONFIG := veux_defconfig

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security patch
BOOT_SECURITY_PATCH := 2025-12-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)
