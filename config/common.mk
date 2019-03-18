PRODUCT_BUILD_WPROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/xperia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xperia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/xperia/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/xperia/config/permissions/xperia-power-whitelist.xml:system/etc/sysconfig/xperia-power-whitelist.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1

# Set custom volume steps
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Disable Rescue Party
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Packages
include vendor/xperia/config/packages.mk

# Media
include vendor/xperia/media/media.mk

# Xapps
$(call inherit-product, vendor/xperia/xapps/xapps.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += vendor/xperia/overlay/common

# Xperia
include vendor/xperia/build/core/version.mk
