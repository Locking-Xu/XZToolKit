//
//  XZImageBrowserViewController.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZImageBrowserViewController : UIViewController

/** 图片名称数组*/
@property (nonatomic, strong) NSArray *imageArray;
/** 当前的下标*/
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
