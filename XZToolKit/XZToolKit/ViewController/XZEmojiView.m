//
//  XZEmojiView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmojiView.h"

@implementation XZEmojiView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self){
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setEmoji:(NSString *)emoji{

    CGSize size = [XZEmojiView emojiSize:@"😄"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        CGRect rect = CGRectMake(0, 0, size.width*[UIScreen mainScreen].scale, size.height*[UIScreen mainScreen].scale);
        UIGraphicsBeginImageContext(rect.size);
        [emoji drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:33.0f*[UIScreen mainScreen].scale]}];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

+ (CGSize)emojiSize:(NSString *)emoji{

    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:33.0f]};
    return [emoji sizeWithAttributes:att];
}

@end
