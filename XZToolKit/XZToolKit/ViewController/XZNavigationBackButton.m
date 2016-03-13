//
//  XZNavigationBackButton.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/13.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZNavigationBackButton.h"
#import "UIView+Frame.h"

@implementation XZNavigationBackButton
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(12, 31, frame.size.width, 22.0f);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38*22/63.0f, 022.0f)];
        imageView.image = [UIImage imageNamed:@"back"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.width +5, 0, self.width- imageView.width - 5, self.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"";
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn_Pressed)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        [self addSubview:label];
    }
    return self;
}



- (void)backBtn_Pressed{

    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end
