//
//  XZMethodMacro.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#ifndef XZMethodMacro_h
#define XZMethodMacro_h

/** 快速定义weakSelf*/
#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self;

/** 设置颜色*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
/** 设置随机颜色*/
#define RandomColor [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+0.5 alpha:1];

/** stringWithFormat*/
#define XZObjectToString(object)    [NSString stringWithFormat:@"%@",object]
#define XZIntToString(int)  [NSString stringWithFormat:@"%ld",(long)int]
#define XZFloatToString(float)  [NSString stringWithFormat:@"%f",float]


/** 获得Bundle的Image*/
#define XZGetImageFromBundle(name,type) \
[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]];    \

#endif /* XZMethodMacro_h */
