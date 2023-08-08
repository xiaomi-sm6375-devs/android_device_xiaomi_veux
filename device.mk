#
# Copyright (C) 2023-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from proprietary targets
$(call inherit-product, vendor/xiaomi/veux/veux-vendor.mk)
