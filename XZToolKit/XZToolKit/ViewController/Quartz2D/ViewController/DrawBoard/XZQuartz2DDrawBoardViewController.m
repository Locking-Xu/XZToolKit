//
//  XZQuartz2DDrawBoardViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DDrawBoardViewController.h"
#import "XZQuartz2DDrawBoardView.h"

@interface XZQuartz2DDrawBoardViewController (){

    NSArray *_colors;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *kindSegment;
@property (weak, nonatomic) IBOutlet XZQuartz2DDrawBoardView *drawView;

@end

@implementation XZQuartz2DDrawBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor cyanColor],[UIColor blackColor]];
    
    self.drawView.currentColor = _colors[self.colorSegment.selectedSegmentIndex];
    self.drawView.kind = self.kindSegment.selectedSegmentIndex;
    
    [self.colorSegment addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    [self.kindSegment addTarget:self action:@selector(changeKind:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton_Action
- (void)changeColor:(UISegmentedControl *)sender{
    
    self.drawView.currentColor = _colors[sender.selectedSegmentIndex];
}

- (void)changeKind:(UISegmentedControl *)sender{

    self.drawView.kind = sender.selectedSegmentIndex;
}

@end
