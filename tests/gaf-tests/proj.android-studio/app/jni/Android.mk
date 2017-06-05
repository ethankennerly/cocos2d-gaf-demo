LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

GAF_LIB_SOURCES := $(LOCAL_PATH)/../../../Library/Sources

LOCAL_MODULE := cpp_empty_test_shared

LOCAL_MODULE_FILENAME := libcpp_empty_test

LOCAL_ARM_MODE := arm

CLASSES_FILES := $(wildcard $(GAF_LIB_SOURCES)/*.cpp)

LOCAL_SRC_FILES := main.cpp \
                   ../../../Classes/AppDelegate.cpp \
                   ../../../Classes/GafFeatures.cpp \
                   $(CLASSES_FILES:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Classes \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/extensions \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/cocos \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/cocos/editor-support \
                    $(GAF_LIB_SOURCES)

LOCAL_STATIC_LIBRARIES := cocos2dx_static

include $(BUILD_SHARED_LIBRARY)

$(call import-module,.)
