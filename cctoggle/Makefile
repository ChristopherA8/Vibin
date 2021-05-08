TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = cctoggle
cctoggle_BUNDLE_EXTENSION = bundle
cctoggle_FILES = $(wildcard *.m)
cctoggle_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei
cctoggle_PRIVATE_FRAMEWORKS = ControlCenterUIKit
cctoggle_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
