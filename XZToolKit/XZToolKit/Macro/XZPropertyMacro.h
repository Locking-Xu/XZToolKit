//
//  XZPropertyMacro.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#ifndef XZPropertyMacro_h
#define XZPropertyMacro_h

/** 屏幕宽度*/
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
/** 屏幕高度*/
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 设备的种类*/
#define IPHONE  [[UIDevice currentDevice].localizedModel isEqualToString:@"iPhone"]
#define ITOUCH    [[UIDevice currentDevice].localizedModel isEqualToString:@"iPod touch"]
#define IPAD    [[UIDevice currentDevice].localizedModel isEqualToString:@"iPad"]

/** 当前设备系统版本*/
#define DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] integerValue]

/** iPhone的型号*/
#define iPhone4_4S      UISCREEN_HEIGHT == 480 ? YES : NO

#define iPhone5_5S_5C   UISCREEN_HEIGHT == 568 ? YES : NO

#define iPhone6_6S      UISCREEN_HEIGHT == 667 ? YES : NO

#define iPhone6P_6SP    UISCREEN_HEIGHT == 736 ? YES : NO

#endif /* XZPropertyMacro_h */
