//
//  XZLabelFlowThreeView.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowThreeView.h"
#import "XZUtils.h"


@interface XZLabelFlowThreeView(){
    XZLabelFlowThreeConfig *_config;
}
@end
@implementation XZLabelFlowThreeView

- (instancetype)initWithFrame:(CGRect)frame config:(XZLabelFlowThreeConfig *)config{
    
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        self.contentInset = _config.edgeInsets;
        [self addTags];
    }
    return self;
}

#pragma mark - Private_Methods
- (void)addTags{
    
    switch (_config.lineType) {
        case SingleLine:
            //单行
            [self singleType];
            break;
        case MultipleLine:
            //多行
            [self multipleLine];
            break;
        default:
            break;
    }
}


- (void)singleType{
    NSArray *array = _config.titleArray;
    
    CGFloat last_X = 0.0f;
    
    for (NSInteger index = 0; index<array.count ; index++) {
        
        NSString *title = array[index];
        
        CGSize size = [XZUtils stringAdaptive:title height:_config.itemHeigth lineSpace:0 font:_config.itemTextFont mode:NSLineBreakByCharWrapping];
        
        CGFloat width = size.width + 2*_config.itemTextSpace;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(last_X, 0, width, _config.itemHeigth)];
        button.tag = index;
        [button addTarget:self action:@selector(tagBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = _config.itemBackgroundColor;
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:_config.itemTextFont];
        [button setTitleColor:_config.itemTextColor forState:UIControlStateNormal];
        if (_config.itemRadius > 0.0f) {
            button.layer.cornerRadius = _config.itemRadius;
            button.layer.masksToBounds = YES;
        }
        if (_config.itemBorderWidth > 0.0f) {
            button.layer.borderColor = _config.itemBorderColor.CGColor;
            button.layer.borderWidth = _config.itemBorderWidth;
        }
        [self addSubview:button];

        
        last_X += width + _config.itemSpace;
    }

    self.contentSize = CGSizeMake(last_X - _config.itemSpace, 1.0f);
}

- (void)multipleLine{
    
    NSArray *array = _config.titleArray;
    CGFloat last_X = 0.0f;
    CGFloat last_Y = 0.0f;
    NSInteger lineNumber = 0;
    for (NSInteger index = 0; index < array.count; index ++) {
        
        NSString *title = array[index];
        
        CGSize size = [XZUtils stringAdaptive:title height:_config.itemHeigth lineSpace:0 font:_config.itemTextFont mode:NSLineBreakByCharWrapping];
        
        CGFloat width = size.width + 2*_config.itemTextSpace;
        
        UIButton *button = [[UIButton alloc] init];
        button.tag = index;
        [button addTarget:self action:@selector(tagBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = _config.itemBackgroundColor;
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:_config.itemTextFont];
        [button setTitleColor:_config.itemTextColor forState:UIControlStateNormal];
        if (_config.itemRadius > 0.0f) {
            button.layer.cornerRadius = _config.itemRadius;
            button.layer.masksToBounds = YES;
        }
        if (_config.itemBorderWidth > 0.0f) {
            button.layer.borderColor = _config.itemBorderColor.CGColor;
            button.layer.borderWidth = _config.itemBorderWidth;
        }
        [self addSubview:button];
        
        if ((self.bounds.size.width - last_X - _config.edgeInsets.right)<width) {
            
            last_X = 0.0;
            lineNumber++;
        }
        
        last_Y = (_config.itemHeigth + _config.lineSpace)*lineNumber;
        
        button.frame = CGRectMake(last_X, last_Y, width, _config.itemHeigth);
        
        last_X += width + _config.itemSpace;
        
    }
    
    self.contentSize = CGSizeMake(1, last_Y + _config.itemHeigth);
}

#pragma mark - UIButton_Actions
- (void)tagBtn_Pressed:(UIButton *)sender{
    
    if (self.labelFlowThreeDelegate && [self.labelFlowThreeDelegate respondsToSelector:@selector(clickTagAtIndex:title:)]) {
        [self.labelFlowThreeDelegate clickTagAtIndex:sender.tag title:sender.currentTitle];
    }
}
@end
