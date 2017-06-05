# Cocos2d-x GAF Demo through Android Studio

This is a demo of using Cocos2D-x and GAF Converter through Android Studio.  I used the GAF team's demo and added a couple more examples to prove the pipeline.

GAF (Generic Animation Format) Converter converts Flash Animation output files into GAF, which can play in Cocos2D-x or Unity.

Here is another developer's example of GAF with nested animations.

<https://gafmedia.com/examples/cocos2dx/casino-slot-machine>


## Installation

- [ ] Install Cocos2D-x v3.15.
- [ ] Install Android Studio 2.3.
- [ ] Install Android SDK.
- [ ] Install Android NDK.

## Installation Details


Windows Android Studio

<http://cocos2d-x.org/docs/installation/Android-terminal/index.html>

<http://cocos2d-x.org/docs/installation/Android-Studio/>

Install Android NDK

<https://developer.android.com/ndk/guides/index.html>

Set environment variable of `NDK_ROOT`.  Mine was here:

	C:\Program Files\Android\Android Studio\plugins\android-ndk

<https://stackoverflow.com/questions/27522184/android-ndk-default-location>

Install Apache Ant

<https://www.mkyong.com/ant/how-to-install-apache-ant-on-windows/>

<http://aprogrammersday.blogspot.com/2015/02/cocos2d-x-game-development-in-android.html>

<http://discuss.cocos2d-x.org/t/3-10-and-android-studio/27720/2>

Android studio SDK path to environment variable.  Mine was here:

	C:\Users\Ethan\AppData\Local\Android\Sdk

Add ADB to path.  My adb was here.

	C:\Program Files (x86)\Android\android-sdk\platform-tools

Otherwise there will be failure building:

	05/28 16:20:07: Launching CppTests
	$ adb push C:\Users\Ethan\workspace\cocos2d-x\tests\cpp-tests\proj.android-studio\app\build\outputs\apk\CppTests-debug.apk /data/local/tmp/org.cocos2dx.cpp_tests
	$ adb shell pm install -r "/data/local/tmp/org.cocos2dx.cpp_tests"
	Error: Could not access the Package Manager.  Is the system running?

	$ adb shell pm uninstall org.cocos2dx.cpp_tests
	Unknown failure (Failure)
	Error while Installing APK

#### Setup Cocos2D

Command Line tool

<http://cocos2d-x.org/docs/editors_and_tools/cocosCLTool/>

	cd cocos2d-x

	Run python setup.py

Compile

	cocos compile -p android --android-studio

Or these steps:
<http://discuss.cocos2d-x.org/t/3-10-and-android-studio/27720/2>

Open Android Studio.
Open CppTests.

From Android SDK Manager:
- [ ] Install Android-22.
- [ ] Install Android Build Tools 25.

Open Android Virtual Device manager.  My Android HUD and buttons consuming a lot of the screen, so I selected a smaller resolution:  240x320 (QVGA).  Otherwise I saw black screen.  Run.  Rotate screen.

I closed other programs to conserve memory.  I allocated more memory to Gradle:

	proj.android-studio/gradle.properties:
	org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8

Edited Android make file:

	project.android-studio/app/jni/Android.mk

Change source files:

	LOCAL_SRC_FILES := main.cpp \
			   ../../../Classes/AppDelegate.cpp \
			   ../../../Classes/HelloWorldScene.cpp


#### Building GAF Tests

Included GAF

	GAF_LIB_SOURCES := $(LOCAL_PATH)/../Library/Sources

	LOCAL_SRC_FILES := main.cpp \
			   ../../../Classes/AppDelegate.cpp \
			   ../../../Classes/GafFeatures.cpp \
                            $(GAF_LIB_SOURCES)

I imported Android project into Android Studio.

<https://developer.android.com/studio/intro/migrate.html>

Updated build.gradle to current version:

        classpath 'com.android.tools.build:gradle:2.3.2'

Set `NDK_MODULE_PATH` in Windows environment variable.

Sync Gradle.

In Android Studio, project settings, selected:  "Link Project with C++"

<https://developer.android.com/studio/projects/add-native-code.html#link-gradle>

Did not Configure to use deprecated NDK.

<https://stackoverflow.com/questions/31979965/after-updating-android-studio-to-version-1-3-0-i-am-getting-ndk-integration-is>

Included new animation with walk animation.

#### Extracting project

Cocos2D-x is a separate repo.  I didn't want a duplicate of such a large repo, even as a submodule.

I tested revision 3.15 of Cocos2d-x, specifically this commit:

	commit 21d22047a60b4ac8d399171ab660ca9e2e1f6024
	Merge: f0080bf ae8e83b
	Author: 子龙山人 <guanghui8827@126.com>
	Date:   Fri May 5 16:12:40 2017 +0800

	    Merge pull request #17781 from zilongshanren/fix-editbox-textchanged-calltimes

        fix editbox textChanged call times on Android platform

I changed paths to refer to this parallel directory:

	cocos2d-gaf-demo
	cocos2d-x

Here are the files and lines after editing:

	tests/gaf-tests/Library/Android.mk:
	CCX_ROOT_2 := $(LOCAL_PATH)/../../../../cocos2d-x

	tests/gaf-tests/proj.android-studio/settings.gradle:
	project(':libcocos2dx').projectDir = new File(settingsDir, '../../../../cocos2d-x/cocos/platform/android/libcocos2dx')

	tests/gaf-tests/proj.android-studio/app/build.gradle:
                    def module_paths = [project.file("../../../../../cocos2d-x").absolutePath,
                                        project.file("../../../../../cocos2d-x/cocos").absolutePath,
                                        project.file("../../../../../cocos2d-x/external").absolutePath,

	tests/gaf-tests/proj.android-studio/app/jni/Android.mk:
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/extensions \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/cocos \
                    $(LOCAL_PATH)/../../../../../../cocos2d-x/cocos/editor-support \



# Credits

GAF Converter:  The GAF code in Library was generously provided by GAF team and has their own license, which is only free for small projects and requires their logo appear on your splash screen.    <https://gafmedia.com>

CatalystApps made the tests:  <https://github.com/CatalystApps/Cocos2dxGAFPlayer> and has their own copyright.

I made a few modifications to compile the source code with Cocos2d-x v 3.15.

Cocos2D-x v 3.15:  Open source mobile game engine.

Android Studio 2.3
