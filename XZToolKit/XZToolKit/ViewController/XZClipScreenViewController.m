//
//  XZClipScreenViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZClipScreenViewController.h"
#import "UIView+Clip.h"

@interface XZClipScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XZClipScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clipFullScreenBtn_Pressed:(id)sender {
    
    self.imageView.image = [self.view imageWithRect:CGRectZero];

}
- (IBAction)clipRectScreenBtn_Pressed:(id)sender {
    self.imageView.image = [self.view imageWithRect:CGRectMake(0, 0, 100, 100)];
}

@end
