//
//  XZEmojiPreview.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEmojiPreview.h"

@implementation XZEmojiPreview

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:CGRectMake(0, 0, 102.5, 100)];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.font = [UIFont systemFontOfSize:33.0f];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor  = [UIColor redColor];
        [self addSubview:self.label];
    }
    return self;
}

@end
