//
//  XZLogMacro.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#ifndef XZLogMacro_h
#define XZLogMacro_h

#define VarString(var) [NSString stringWithFormat:@"%s",#var]

/** 打印对象*/
#define XZObjectLog(object) NSLog(@"%@ = %@",VarString(object),object);

/** 打印Int*/
#define XZIntLog(int) NSLog(@"%@ = %ld",VarString(int),(long)int);

/** 打印Float*/
#define XZFloatLog(float) NSLog(@"%@ = %f",VarString(float),float);

/** 打印BOOL*/
#define XZBoolLog(bool) \
if(bool == 0)    \
NSLog(@"%@ = NO",VarString(bool));    \
else    \
NSLog(@"%@ = YES",VarString(bool));    \

/** 打印CGSize*/
#define XZSizeLog(size) NSLog(@"%@ = %@",VarString(size),NSStringFromCGSize(size));

/** 打印CGPoint*/
#define XZPointLog(point)   NSLog(@"%@ = %@",VarString(point),NSStringFromCGPoint(point));

/** 打印CGRect*/
#define XZRectLog(rect) NSLog(@"%@ = %@",VarString(rect),NSStringFromCGRect(rect));

/** 打印NSRange*/
#define XZRangeLog(range)   NSLog(@"%@ = %@",VarString(range),NSStringFromRange(range));

#endif /* XZLogMacro_h */
