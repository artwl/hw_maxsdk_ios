#!/usr/bin/env python3
"""Validate HW iOS SDK bridge examples against the V9.8.77 public API."""

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]


def read(relative_path):
    return (ROOT / relative_path).read_text(encoding="utf-8-sig")


def require_contains(relative_path, needle, label):
    text = read(relative_path)
    if needle not in text:
        return f"{relative_path}: missing {label}"
    return None


def require_regex(relative_path, pattern, label):
    text = read(relative_path)
    if not re.search(pattern, text, re.MULTILINE | re.DOTALL):
        return f"{relative_path}: missing {label}"
    return None


CHECKS = [
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.h",
        "void initHwSDK(int serverURL, BOOL isFirebase, BOOL isABTestOpen, BOOL isMerge);",
        "4-argument initHwSDK declaration",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.h",
        "const char *hwSdkVersion(void);",
        "const char * sdk version declaration",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.cs",
        "private static extern void initHwSDK(int serverURL, bool isFirebase, bool isABTestOpen, bool isMerge);",
        "4-argument C# init import",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.cs",
        "public static void InitSdk(int serverURL, bool isFirebase = true, bool isABTestOpen = false, bool isMerge = false)",
        "configurable Unity InitSdk wrapper",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.cs",
        "private static extern IntPtr hwSdkVersion();",
        "IntPtr C# sdk version import",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.cs",
        "return versionPtr == IntPtr.Zero ? string.Empty : Marshal.PtrToStringAnsi(versionPtr);",
        "safe C# sdk version marshal",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "void initHwSDK(int serverURL, BOOL isFirebase, BOOL isABTestOpen, BOOL isMerge)",
        "4-argument native init implementation",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "[[HwAds instance] initSDK:serverURL isFirebase:isFirebase isABTestOpen:isABTestOpen isMerge:isMerge];",
        "V9.8.77 initSDK call",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "- (void)hwAdsRewardedVideoLoadFailWithErrorCode:(NSInteger)errorCode",
        "reward load fail callback with error code",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "- (void)hwAdsRewardedVideoPlayFailWithErrorCode:(NSInteger)errorCode",
        "reward play fail callback with error code",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "const char *hwSdkVersion(void)",
        "const char * sdk version implementation",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        "[HwAds sdkVersion]",
        "class sdkVersion call",
    ),
    (
        "hwsdk_ios_unity_example/unity/HwAdsInterface.h",
        "void initHwSDK(int serverURL, BOOL isFirebase, BOOL isABTestOpen, BOOL isMerge);",
        "legacy 4-argument init declaration",
    ),
    (
        "hwsdk_ios_unity_example/unity/HwAdsInterface.cs",
        "private static extern void initHwSDK(int serverURL, bool isFirebase, bool isABTestOpen, bool isMerge);",
        "legacy 4-argument C# init import",
    ),
    (
        "hwsdk_ios_unity_example/unity/HwAdsInterface.m",
        "[[HwAds instance] initSDK:serverURL isFirebase:isFirebase isABTestOpen:isABTestOpen isMerge:isMerge];",
        "legacy V9.8.77 initSDK call",
    ),
    (
        "hwsdk_ios_unity_example/ios/HwAdsInterface.h",
        "void initHwSDK(int serverURL, BOOL isFirebase, BOOL isABTestOpen, BOOL isMerge);",
        "ios 4-argument init declaration",
    ),
    (
        "hwsdk_ios_unity_example/ios/HwAdsInterface.m",
        "[[HwAds instance] initSDK:serverURL isFirebase:isFirebase isABTestOpen:isABTestOpen isMerge:isMerge];",
        "ios V9.8.77 initSDK call",
    ),
    (
        "cocos/HwAdsCocos.h",
        "+(void)initSDK:(NSString *)projectId isFirebase:(NSString *)isFirebase isABTestOpen:(NSString *)isABTestOpen isMerge:(NSString *)isMerge;",
        "Cocos configurable init declaration",
    ),
    (
        "cocos/HwAdsCocos.m",
        "[self.hwads initSDK:[projectId intValue] isFirebase:[isFirebase boolValue] isABTestOpen:[isABTestOpen boolValue] isMerge:[isMerge boolValue]];",
        "Cocos V9.8.77 initSDK call",
    ),
    (
        "cocos/HwAdsCocos.m",
        "- (void)hwAdsRewardedVideoLoadFailWithErrorCode:(NSInteger)errorCode",
        "Cocos reward load fail callback with error code",
    ),
    (
        "cocos/HwAdsCocos.m",
        "- (void)hwAdsRewardedVideoPlayFailWithErrorCode:(NSInteger)errorCode",
        "Cocos reward play fail callback with error code",
    ),
    (
        "cocos/HelloWorld.js",
        '"initSDK:isFirebase:isABTestOpen:isMerge:"',
        "Cocos JS configurable init call",
    ),
]


REGEX_CHECKS = [
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        r"hwAdsRewardedVideoLoadFailWithErrorCode:[\s\S]*UnitySendMessage\(\"HwAdsCallBack\", \"RewardCallBack\", \"false\"\)",
        "Unity reward failure callback reports false",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        r"hwAdsRewardedVideoGiveReward[\s\S]*UnitySendMessage\(\"HwAdsCallBack\", \"RewardCallBack\", \"true\"\)",
        "Unity reward success callback reports true",
    ),
    (
        "hwsdk_ios_unity_example/Unity-iOS/HwAdsInterface.m",
        r"hwAdsInterstitialClose[\s\S]*UnitySendMessage\(\"HwAdsCallBack\", \"InterCallBack\", \"true\"\)",
        "Unity inter close callback reports true",
    ),
]


def main():
    failures = []
    for relative_path, needle, label in CHECKS:
        failure = require_contains(relative_path, needle, label)
        if failure:
            failures.append(failure)
    for relative_path, pattern, label in REGEX_CHECKS:
        failure = require_regex(relative_path, pattern, label)
        if failure:
            failures.append(failure)

    if failures:
        print("Bridge validation failed:")
        for failure in failures:
            print(f"- {failure}")
        return 1

    print("Bridge validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
