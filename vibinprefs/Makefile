TARGET := iphone:clang:latest:7.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = vibinprefs

vibinprefs_FILES = $(wildcard *.m)
vibinprefs_FRAMEWORKS = UIKit
vibinprefs_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
vibinprefs_INSTALL_PATH = /Library/PreferenceBundles
vibinprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
