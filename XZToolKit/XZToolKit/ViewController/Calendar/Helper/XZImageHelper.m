//
//  XZImageHelper.m
//  XZYearCalendar
//
//  Created by 徐章 on 16/1/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

/**
 *  该类时间每个月的日历绘制成一张图片再传给界面显示
 */

#import "XZImageHelper.h"
#import "XZGlyphsHelper.h"
#import "NSDate+String.h"
#import "XZUtils.h"

/** 7列*/
static NSUInteger const monthColumns = 7;
/** 6行*/
static NSUInteger const monthRows = 6;

static XZImageHelper *imageHelper = nil;

@interface XZImageHelper()

@property (nonatomic, strong) XZGlyphsHelper *glyphsHepler;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation XZImageHelper

+ (XZImageHelper *)shareInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        imageHelper = [[XZImageHelper alloc] init];
    });
    
    return imageHelper;
}

/**
 *  单例使用的安全
 */
+ (id)alloc{
    
    @synchronized([XZImageHelper class]) {
        
        NSAssert(imageHelper == nil, @"这是一个单例，不能再被alloc了");
        
        imageHelper = [super alloc];
        
        return imageHelper;
    }
}

- (id)init{
    
    self = [super init];
    if (self) {
        
        [self resetImageHelper];
    }
    
    return self;
}

- (void)resetImageHelper{
    
    _dateFormatter = [NSDateFormatter new];
    [_dateFormatter setDateFormat:@"MMMM"];
    
    _glyphsHepler = [XZGlyphsHelper glyphsHelperWithFontName:@"Helvetica" fontSize:8.0f];
}

#pragma mark CGContexrRef & CGImageRef
/**
 *  创建CGContextRef
 *
 *  @param size CGContext的size
 *
 *  @return CGContextRef
 */
CG_INLINE CGContextRef CGContextCreate(CGSize size){
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width * scale, size.height * scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextScaleCTM(context, scale, scale);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //处理context颠倒问题
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,size.height);
    transform = CGAffineTransformScale(transform, 1.0, -1.0);
    CGContextSetTextMatrix(context, transform);

    CGColorSpaceRelease(colorSpace);
    
    return context;
    
}

/**
 *  从CGContextRef转成图片
 *
 *  @param context CGContext
 *
 *  @return 图片
 */
CG_INLINE UIImage* UIGraphicsGetImageFromContext(CGContextRef context){

    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationDownMirrored];
    CGImageRelease(cgImage);
    
    return image;
}

#pragma mark Private_Methods
/**
 *  获得年日历的图片
 *
 *  @param date 日期
 *  @param size 尺寸
 *
 *  @return UIImage
 */
- (UIImage *)getMonthImageWithDate:(NSDate *)date size:(CGSize)size{
    
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        
        CGContextRef context = CGContextCreate(size);
        
        [self drawMonthInContext:context date:date size:size];
        
        UIImage *image = UIGraphicsGetImageFromContext(context);
        
        CGContextRelease(context);
        
        return image;
    }
    return nil;
} 

/**
 *  获得月日历的图片
 *
 *  @param date 日期
 *  @param size 尺寸
 *
 *  @return UIImage
 */
- (UIImage *)getDayImageWithDate:(NSDate *)date size:(CGSize)size{
    
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        
        CGContextRef context = CGContextCreate(size);
        
        [self drawDayInContext:context date:date size:size];
        
        UIImage *image = UIGraphicsGetImageFromContext(context);
        
        CGContextRelease(context);
        
        return image;
    }
    return nil;
}

/**
 *  绘制月日历
 *
 *  @param context CGContextRef
 *  @param date    日期
 *  @param size    尺寸
 */
- (void)drawDayInContext:(CGContextRef)context date:(NSDate *)date size:(CGSize)size{
    
    XZObjectLog(date);
    
    CGRect gregorianRect = CGRectMake(0, 0, size.width, size.height*2/3);
    
    [self drawGregorianDate:context rect:gregorianRect title:[NSDate stringFromDate:date format:@"d"]];

}

/**
 *  绘制月日历中的内容
 *
 *  @param context CGcontextRef
 *  @param rect    绘制的范围
 *  @param title   绘制的内容
 */
- (void)drawGregorianDate:(CGContextRef)context rect:(CGRect)rect title:(NSString *)title{
    
    CGSize size = [XZUtils stringAdaptive:title width:0 lineSpace:0 font:20.0f mode:NSLineBreakByCharWrapping];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    rect.origin.x = (rect.size.width - size.width)/2;
    
    CGPathAddRect(path, NULL, rect);
    
    NSDictionary *dic = @{
                          (id)kCTForegroundColorAttributeName:(id)[UIColor blackColor].CGColor,
                          NSFontAttributeName:[UIFont systemFontOfSize:20.0f]
                          };
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:dic];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path,NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

/**
 *  绘制日历
 *
 *  @param context CGContextRef
 *  @param date    绘制的月份
 *  @param size    绘制的大小
 *
 *  @return CGContextRef
 */
- (CGContextRef)drawMonthInContext:(CGContextRef)context date:(NSDate *)date size:(CGSize)size{
    
    //月份标题高度
    CGFloat monthTitleHeight =20.0f;
    CGRect monthTitleFrame = CGRectMake(0, 0, size.width, monthTitleHeight);
    
    //天一共所占的区域
    CGSize dayAreaSize = CGSizeMake(size.width, size.height - monthTitleHeight);
    
    
    [self drawDayOfMonthInContext:context date:date size:size dayAreaSize:dayAreaSize];
    
    [self drawTitleOfMonthInContext:context rect:monthTitleFrame title:[_dateFormatter stringFromDate:date]];
    return context;
}

/**
 *  绘制月份Title
 *
 *  @param context CGContextRef
 *  @param rect    绘制的区域
 *  @param title   标题
 */
- (void)drawTitleOfMonthInContext:(CGContextRef)context rect:(CGRect)rect title:(NSString *)title{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    NSDictionary *dic = @{
                          (id)kCTForegroundColorAttributeName:(id)[UIColor redColor].CGColor,
                          NSFontAttributeName:[UIFont systemFontOfSize:12.0f]
                          };
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:dic];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path,NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}

/**
 *  绘制月份中的每一天
 *
 *  @param context     CGContextRef
 *  @param date        日期
 *  @param size        CGSize
 *  @param dayAreaSize 绘制区域大小
 */
- (void)drawDayOfMonthInContext:(CGContextRef)context date:(NSDate *)date size:(CGSize)size dayAreaSize:(CGSize)dayAreaSize{
    
    //一天所占的区域
    CGSize daySize = CGSizeMake(size.width/monthColumns, dayAreaSize.height/monthRows);
    
    //日期的下标
    NSInteger weekDayIndex = [date weekDay] - 1;
    
    CGPoint *glyphsPosition = (CGPoint *)malloc(sizeof(CGPoint) * _glyphsHepler.length);
    
    //符号串的下标
    NSInteger glyphsIndex = 0;
    
    for (int i=0; i<[date numberOfDayInMonth]; i++) {
        
        CGPoint offset = CGPointMake(weekDayIndex % monthColumns, weekDayIndex / monthColumns);
        
        //日期为一位数
        if (i<9) {
            
            CGSize glyphsAdvance = _glyphsHepler.glyphsAdvances[glyphsIndex];
            //CGContext的颠倒问题导致这边Y坐标需要处理一下
            CGPoint position = CGPointMake(offset.x * daySize.width + 0.5 * (daySize.width - glyphsAdvance.width), dayAreaSize.height - offset.y * daySize.height - 0.5 * (daySize.height - glyphsAdvance.height));

            glyphsPosition[glyphsIndex++] = position;
        }
        //日期为两位数
        else{
            
            CGSize firstGlyphsAdvance = _glyphsHepler.glyphsAdvances[glyphsIndex];
            CGSize secondGlyphsAdvance = _glyphsHepler.glyphsAdvances[glyphsIndex+1];
            
            CGFloat postionY = dayAreaSize.height - offset.y * daySize.height - 0.5 * (daySize.height - firstGlyphsAdvance.height);
            
            CGPoint firstPostion = CGPointMake(offset.x * daySize.width + 0.5 * (daySize.width - firstGlyphsAdvance.width - secondGlyphsAdvance.width), postionY);
            
            glyphsPosition[glyphsIndex++] = firstPostion;
            
            glyphsPosition[glyphsIndex++] = CGPointMake(firstPostion.x + firstGlyphsAdvance.width , postionY);
        }
        
        weekDayIndex++;
    }
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CTFontDrawGlyphs(_glyphsHepler.font, _glyphsHepler.glyphs, glyphsPosition, glyphsIndex, context);
    free(glyphsPosition);
    
}
@end
