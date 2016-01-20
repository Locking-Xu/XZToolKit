//
//  XZGlyphsHelper.h
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@interface XZGlyphsHelper : NSObject

/** 符号串的长度*/
@property (nonatomic, assign) NSInteger length;
/** 字体*/
@property (nonatomic, assign) CTFontRef font;
/** 符号串*/
@property (nonatomic, assign) CGGlyph *glyphs;
/** 符号的size数组*/
@property (nonatomic, assign) CGSize *glyphsAdvances;

+ (XZGlyphsHelper *)glyphsHelperWithFontName:(NSString *)fontName fontSize:(CGFloat)fontSize;



@end
