//
//  XZUtils.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZUtils : NSObject
#pragma mark - Common Methods
/**
 *  自适应label的size
 *
 *  @param label     自适应的label
 *  @param width     给定一个宽度
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 *
 *  @return size
 */
+ (CGSize)stringAdaptive:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode;

/**
 *  自适应label的size
 *
 *  @param label     自适应的label
 *  @param width     给定一个高度
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 *
 *  @return size
 */
+ (CGSize)stringAdaptive:(NSString *)content height:(CGFloat)height lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode;

/**
 *  获得当前的ViewController
 *
 *  @return UIViewController
 */
+ (UIViewController *)getCurrentViewController;

#pragma mark - About Empty Object
/**
 *  判断是否为nil、NSNull
 *
 *  @param object 被判断的对象
 *
 *  @return BOOL
 */
+ (BOOL)judgeIsEmptyObject:(id)object;

/**
 *  将是为nil、NSNull进行转换
 *
 *  @param object   被判断对象
 *  @param toObject 转换后对象
 *
 *  @return toObject
 */
+ (id)changeEmptyObject:(id)object to:(id)toObject;

#pragma mark - About Local Data
/**
 *  将数据存到NSUserDefault
 *
 *  @param content 保存的内容
 *  @param key     键值
 */
+ (void)saveDataToLocal:(id)data key:(NSString *)key;

/**
 *  从NSUserDefault读取数据
 *
 *  @param key 键值
 *
 *  @return 数据
 */
+ (id)getDataFromLocal:(NSString *)key;

#pragma mark - About UI
/**
 *  提示框
 *
 *  @param message 内容
 */
+ (void)showAlertView:(NSString *)message;

#pragma mark - About String
/**
 *  验证邮箱是否合法
 *
 *  @param email 邮箱
 *
 *  @return YES：合法、NO：不合法
 */
+ (BOOL)isValidEmail:(NSString *)email;

/**
 *  判断字符串中是否有大写字母
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasUpperLetter:(NSString *)string;

/**
 *  判断字符串中是否有小写字母
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasLowerLetter:(NSString *)string;

/**
 *  判断字符串中是否有数字
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasDigitLetter:(NSString *)string;

/**
 *  判断字符串中是否有特殊字符
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasSpecialLetter:(NSString *)string;

#pragma mark - About Time
/**
 *  现在的时间与某一个时间的间隔
 *
 *  @param lastData 对比的时间
 *
 *  @return 时间差
 */
- (NSString *)timeFromNowToData:(NSString *)lastData;

#pragma mark - About File

#pragma mark - About UIImage
/**
 *  将图片按一定的比例缩放
 *
 *  @param proportion 缩放的比例
 *
 *  @return 新的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toProportion:(CGFloat)proportion;

@end
