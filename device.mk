#
# Copyright (C) 2023-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

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
    checkpoint_gc \
    otapreopt_script

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl

PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    audio.primary.holi \
    audio.r_submix.default \
    audio.usb.default \

PRODUCT_PACKAGES += \
    audioadsprpcd \
    liba2dpoffload \
    libbatterylistener \
    libcomprcapture \
    libexthwplugin \
    libhdmiedid \
    libhfp \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndmonitor \
    libspkrprot \
    libvolumelistener \
    sound_trigger.primary.holi:32

AUDIO_HAL_DIR := hardware/qcom-caf/sm8350/audio
AUDIO_SKU_DIR := sku_holi

PRODUCT_COPY_FILES += \
     $(call find-copy-subdir-files,*,$(LOCAL_PATH)/audio,$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR))

PRODUCT_COPY_FILES += \
    $(AUDIO_HAL_DIR)/configs/holi/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/audio_effects.xml \
    $(AUDIO_HAL_DIR)/configs/holi/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/audio_io_policy.conf \
    $(AUDIO_HAL_DIR)/configs/holi/audio_tuning_mixer.txt:$(TARGET_COPY_OUT_VENDOR)/etc/audio_tuning_mixer.txt

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/r_submix_audio_policy_configuration.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1.vendor \
    com.dsi.ant@1.0.vendor \
    vendor.qti.hardware.bluetooth_audio@2.1.vendor \
    vendor.qti.hardware.btconfigstore@1.0.vendor \
    vendor.qti.hardware.btconfigstore@2.0.vendor

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64

PRODUCT_PACKAGES += \
    vendor.qti.hardware.camera.postproc@1.0.vendor

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.composer-service

PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    vendor.qti.hardware.display.allocator-service

PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.default

PRODUCT_PACKAGES += \
    libdisplayconfig.system.qti \
    libqdMetaData.system \
    vendor.display.config@1.15.vendor \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display_id_4630947081618265473.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630947081618265473.xml

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi

PRODUCT_PACKAGES += \
    com.fingerprints.extension@1.0.vendor \
    libvendor.goodix.hardware.biometrics.fingerprint@2.1.vendor

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi

# Inherit from proprietary targets
$(call inherit-product, vendor/xiaomi/veux/veux-vendor.mk)
