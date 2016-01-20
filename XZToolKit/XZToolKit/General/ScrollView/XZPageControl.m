//
//  XZPageControl.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/20.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPageControl.h"
#import "UIView+Frame.h"

#define PageControlWidth 10.0f
#define PageControlMargin 10.0f

@implementation XZPageControl{
    
    NSMutableArray *_layerArray;
    
}

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, UISCREEN_WIDTH, frame.size.height)];
    if (self) {
        
        _layerArray = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Set_Methods
- (void)setNumberOfPages:(NSInteger)numberOfPages{
    
    _numberOfPages = numberOfPages;
    [self createPageControl];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    
    _currentPage = currentPage;
    
    [self createCurrentPageControl];
}
#pragma Private_Methods
- (void)createPageControl{
    
    //pageControl的其实的X位置
    CGFloat start_X = (self.width - self.numberOfPages * PageControlWidth - (self.numberOfPages - 1) * PageControlMargin)/2;
    
    for (int i=0; i<self.numberOfPages; i++) {
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame =CGRectMake(start_X + i*(PageControlMargin + PageControlWidth), (self.height - PageControlWidth)/2, PageControlWidth, PageControlWidth);
        
        layer.borderColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 1.0f;
        layer.cornerRadius = PageControlWidth/2.0f;
        [self resetLayer:layer];
        
        [_layerArray addObject:layer];
        [self.layer addSublayer:layer];
    }
    
}

- (void)createCurrentPageControl{
    
    for (int i=0 ; i< self.numberOfPages; i++) {
        
        if (i== self.currentPage) {
            
            CALayer *layer = _layerArray[self.currentPage];
            [self selectLayer:layer];
            
        }
        else{
            
            [self resetLayer:_layerArray[i]];
        }
    }
    
    
    
}

- (void)selectLayer:(CALayer *)layer{
    
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    layer.transform = CATransform3DMakeScale (1.2, 1.2,1.0);
}

- (void)resetLayer:(CALayer *)layer{
    
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.transform = CATransform3DIdentity;
    
}


@end
