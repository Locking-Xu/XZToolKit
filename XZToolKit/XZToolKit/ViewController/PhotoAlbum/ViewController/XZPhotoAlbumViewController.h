//
//  XZPhotoAlbumViewController.h
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZPhotoAlbumViewController : UIViewController

//相册的URL(IOS7下使用)
@property (nonatomic, strong) NSURL *groupUrl;
//相册的ID(IOS8下使用)
@property (nonatomic, strong) NSString *groupID;

@end
