#
#  Copyright (C) 2024 The LineageOS Project
#  SPDX-License-Identifier: Apache-2.0
#

# Soong
PRODUCT_SOONG_NAMESPACES += \
    vendor/nxp/opensource/commonsys/packages/apps/Nfc \
    vendor/nxp/opensource/commonsys/external/libnfc-nci \
    vendor/nxp/opensource/interfaces \
    vendor/nxp/opensource/halimpl \
    vendor/nxp/opensource/hidlimpl

# NFC - NXP
PRODUCT_PACKAGES += \
    vendor.nxp.hardware.nfc@2.0-service \
    vendor.nxp.hardware.nfc@2.0.vendor \
    android.hardware.nfc@1.2-service \
    NQNfcNci \
    com.nxp.nfc.nq \
    nfc_nci.nqx.default.hw

# NFC - Config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# Secure Element
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.0.vendor \
    android.hardware.secure_element@1.1.vendor \
    android.hardware.secure_element@1.2.vendor
