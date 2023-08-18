TARGET := iphone:clang:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME=rootless
THEOS_DEVICE_IP=192.168.50.28

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Vibin

Vibin_FILES = $(wildcard *.xm *.m)
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = MediaRemote
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei
Vibin_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += vibinprefs # cctoggle
include $(THEOS_MAKE_PATH)/aggregate.mk


# add back com.opa334.ccsupport to deps if it gets updated for rootless