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
    $(AUDIO_HAL_DIR)/configs/common/bluetooth_qti_hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/bluetooth_qti_hearing_aid_audio_policy_configuration.xml \
    $(AUDIO_HAL_DIR)/configs/holi/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/audio_effects.xml \
    $(AUDIO_HAL_DIR)/configs/holi/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/audio_io_policy.conf \
    $(AUDIO_HAL_DIR)/configs/holi/audio_tuning_mixer.txt:$(TARGET_COPY_OUT_VENDOR)/etc/audio_tuning_mixer.txt

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/$(AUDIO_SKU_DIR)/r_submix_audio_policy_configuration.xml

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from proprietary targets
$(call inherit-product, vendor/xiaomi/veux/veux-vendor.mk)
