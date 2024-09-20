#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc

# API level
BOARD_SHIPPING_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := 30

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service

PRODUCT_PACKAGES += \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio.effect@6.0-impl:32 \
    android.hardware.bluetooth.audio-impl:32 \
    android.hardware.soundtrigger@2.3-impl:32

PRODUCT_PACKAGES += \
    audio.bluetooth.default:32 \
    audio.primary.holi:32 \
    audio.r_submix.default:32 \
    audio.usb.default:32

PRODUCT_PACKAGES += \
    audioadsprpcd \
    liba2dpoffload:32 \
    libbatterylistener:32 \
    libcomprcapture:32 \
    libexthwplugin:32 \
    libhdmiedid:32 \
    libhfp:32 \
    libqcompostprocbundle:32 \
    libqcomvisualizer:32 \
    libqcomvoiceprocessing:32 \
    libsndmonitor:32 \
    libspkrprot:32 \
    libvolumelistener:32 \
    sound_trigger.primary.holi:32

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from proprietary targets
$(call inherit-product, vendor/xiaomi/veux/veux-vendor.mk)
