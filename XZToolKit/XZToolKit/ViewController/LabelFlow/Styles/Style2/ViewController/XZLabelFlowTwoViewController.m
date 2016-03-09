//
//  XZLabelFlowTwoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowTwoViewController.h"
#import "XZLabelFlowTwoView.h"

@interface XZLabelFlowTwoViewController (){

    XZLabelFlowTwoView *_labelFlowView;
}

@end

@implementation XZLabelFlowTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _labelFlowView = [[XZLabelFlowTwoView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 1)
                                                     titles:@[@"中国",@"泰兴市",@"江苏省黄桥中学",@"济川实验初中",@"溪桥镇中心小学",@"徐章"]
                                                selectBlock:^(NSUInteger index, NSString *title) {
        
    }];
    
    [self.view addSubview:_labelFlowView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [_labelFlowView.collectionView reloadData];
}

#pragma mark - UIButtons_Pressed
- (IBAction)insertBtn_Pressed:(id)sender {
    
    [_labelFlowView insertLabelWithTitle:@"CodeLocker" index:0 animation:YES];
}

- (IBAction)multiInsertBtn_Pressed:(id)sender {
    
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
    [set addIndex:1];
    [set addIndex:6];
    [_labelFlowView insertMultiLabelWithTitles:@[@"1111",@"2222"] index:set animation:YES];
}
- (IBAction)deleteBtn_Pressed:(id)sender {
    
    [_labelFlowView deleteLabelAtIndex:0 animation:YES];
}
- (IBAction)multiDeleteBtn_Pressed:(id)sender {
    
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
    [set addIndex:0];
    [set addIndex:11];
    [_labelFlowView deleteMultiLabelAtIndex:set animation:YES];
}
- (IBAction)reloadBtn_Pressed:(id)sender {
}
- (IBAction)animationSwith_Pressed:(id)sender {
}


@end
