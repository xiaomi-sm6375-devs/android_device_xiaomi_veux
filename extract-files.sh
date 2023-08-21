#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=veux
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        odm/etc/build_*.prop)
            sed -i "/marketname/d" "${2}"
            sed -i "s/cert/model/" "${2}"
            ;;
        system_ext/etc/init/wfdservice.rc)
            sed -i "/^service/! s/wfdservice$/wfdservice64/g" "${2}"
            ;;
        system_ext/lib64/libwfdnative.so)
            ${PATCHELF} --remove-needed "android.hidl.base@1.0.so" "${2}"
            ;;
        vendor/etc/camera/camxoverridesettings.txt)
            sed -i "s/0x10080/0/g" "${2}"
            sed -i "s/0x1F/0x0/g" "${2}"
            ;;
        vendor/etc/init/init.batterysecret.rc)
            sed -i "s/on charger/on property:init.svc.vendor.charger=running/g" "${2}"
            ;;
        vendor/etc/libnfc-pn557.conf)
            grep -q "NXP RF" "${2}" || cat "${SRC}/vendor/libnfc-nxp_RF.conf" >> "${2}"
            ;;
        vendor/lib64/android.hardware.secure_element@1.0-impl.so)
            ${PATCHELF} --remove-needed "android.hidl.base@1.0.so" "${2}"
            ;;
        vendor/lib64/camera/components/com.qti.node.mialgocontrol.so)
            llvm-strip --strip-debug "${2}"
            grep -q "libpiex_shim.so" "${2}" || "${PATCHELF}" --add-needed "libpiex_shim.so" "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
