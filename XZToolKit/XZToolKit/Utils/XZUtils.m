//
//  XZUtils.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/8.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZUtils.h"
#import "NSDate+String.h"

@implementation XZUtils
#pragma mark - Common Methods
/**
 *  自适应label的frame
 *
 *  @param label     自适应的label
 *  @param width     如果自适应高度，给定一个宽度，高度填0|如果自适应宽度，给定一个高度，宽度填0
 *  @param height    如果自适应高度，给定一个宽度，高度填0|如果自适应宽度，给定一个高度，宽度填0
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 */
+ (CGSize)stringAdaptive:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode{
    
    NSMutableParagraphStyle *paragraphStyle = ({
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];;
        
        [style setLineBreakMode:lineBrekMode];
        
        if (lineSpace != 0) {
            
            style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:lineSpace];//调整行间距
        }
        
        style;
        
    });
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:font],
                                                  NSParagraphStyleAttributeName:paragraphStyle
                                                  }
                                        context:nil].size;
    
    return size;
}

#pragma mark - About Empty Object
/**
 *  判断是否为nil、NSNull
 *
 *  @param object 被判断的对象
 *
 *  @return BOOL
 */
+ (BOOL)judgeIsEmptyObject:(id)object{
    
    if (!object)
        return YES;
    if ([object isKindOfClass:[NSNull class]])
        return YES;
    return NO;
}

/**
 *  将是为nil、NSNull进行转换
 *
 *  @param object   被判断对象
 *  @param toObject 转换后对象
 *
 *  @return toObject
 */
+ (id)changeEmptyObject:(id)object to:(id)toObject{
    
    if ([XZUtils judgeIsEmptyObject:object]) {
        
        return toObject;
    }
    return object;
}

#pragma mark - About Local Data
/**
 *  将数据存到NSUserDefault
 *
 *  @param content 保存的内容
 *  @param key     键值
 */
+ (void)saveDataToLocal:(id)data key:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

/**
 *  从NSUserDefault读取数据
 *
 *  @param key 键值
 *
 *  @return 数据
 */
+ (id)getDataFromLocal:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

#pragma mark - About UI
/**
 *  提示框
 *
 *  @param message 内容
 */
+ (void)showAlertView:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - About String
/**
 *  验证邮箱是否合法
 *
 *  @param email 邮箱
 *
 *  @return YES合法、NO不合法
 */
+ (BOOL)isValidEmail:(NSString *)email{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject: email];
}

/**
 *  判断字符串中是否有大写字母
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasUpperLetter:(NSString *)string{
    
    BOOL upperCaseLetter = NO;
    
    for (int i=0; i<string.length; i++) {
        
        unichar c = [string characterAtIndex:i];
        
        upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
        
        if (upperCaseLetter)
            return upperCaseLetter;
    }
    return NO;
}

/**
 *  判断字符串中是否有小写字母
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasLowerLetter:(NSString *)string{
    
    BOOL lowerCaseLetter = NO;
    
    for (int i=0; i<string.length; i++) {
        
        unichar c = [string characterAtIndex:i];
        
        lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
        
        if (lowerCaseLetter)
            return lowerCaseLetter;
    }
    return NO;
}

/**
 *  判断字符串中是否有数字
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasDigitLetter:(NSString *)string{
    
    BOOL digitCaseLetter = NO;
    
    for (int i=0; i<string.length; i++) {
        
        unichar c = [string characterAtIndex:i];
        
        digitCaseLetter = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
        
        if (digitCaseLetter)
            return digitCaseLetter;
    }
    return NO;
    
}

/**
 *  判断字符串中是否有特殊字符
 *
 *  @param string 字符串
 *
 *  @return YES：有、NO：没有
 */
+ (BOOL)hasSpecialLetter:(NSString *)string{
    
    BOOL specialCaseLetter = NO;
    
    for (int i=0; i<string.length; i++) {
        
        unichar c = [string characterAtIndex:i];
        
        specialCaseLetter = [[NSCharacterSet symbolCharacterSet] characterIsMember: c] ||
        [[NSCharacterSet controlCharacterSet] characterIsMember: c] ||
        [[NSCharacterSet illegalCharacterSet] characterIsMember: c] ||
        [[NSCharacterSet punctuationCharacterSet] characterIsMember: c];
        
        if (specialCaseLetter)
            return specialCaseLetter;
    }
    return NO;
}

#pragma mark - About Time
/**
 *  现在的时间与某一个时间的间隔
 *
 *  @param lastData 对比的时间
 *
 *  @return 时间差
 */
- (NSString *)timeFromNowToData:(NSString *)lastData{
    
    if (lastData == nil){
        
        return @"很久";
    }
    
    NSDate *now = [NSDate date];
    
    NSDate *date = [NSDate dateFromString:lastData format:nil];
    
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    
    NSString *format;
    
    if (interval <= 60) {
        
        format = [NSString stringWithFormat:@"%d 秒", (int)interval];
        
    } else if(interval <= 60*60){
        
        format = [NSString stringWithFormat:@"%d 分钟", (int)interval/60];
        
    } else if(interval <= 60*60*24){
        
        format = [NSString stringWithFormat:@"%d 小时", (int)interval/3600];
        
    } else if (interval <= 60*60*24*7){
        
        format = [NSString stringWithFormat:@"%d 天", (int)interval/(60*60*24)];
        
    } else if (interval > 60*60*24*7 & interval <= 60*60*24*30 ){
        
        format = [NSString stringWithFormat:@"%d 周", (int)interval/(60*60*24*7)];
        
    }else if(interval > 60*60*24*30 ){
        
        format = [NSString stringWithFormat:@"%d 月", (int)interval/(60*60*24*30)];
    }
    
    return format;
    
}
@end
