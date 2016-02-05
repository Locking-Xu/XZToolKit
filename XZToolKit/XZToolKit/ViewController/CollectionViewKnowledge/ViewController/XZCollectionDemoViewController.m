//
//  XZCollectionDemoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCollectionDemoViewController.h"
#import "XZCollectionLayoutStyleOne.h"
#import "XZCollectionLayoutStyleTwo.h"
#import "XZCollectionLayoutStyleThree.h"
#import "XZCollectionDemoCell.h"
#import "NSString+Format.h"

@interface XZCollectionDemoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    UICollectionView *_collectionView;
    NSInteger _cellCount;
}

@end

@implementation XZCollectionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellCount = 20;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    
    UICollectionViewLayout *layout;
    
    if ([self.title isEqualToString:@"Layout样式一"]) {
        
        layout = [[XZCollectionLayoutStyleOne alloc] init];
        
    }else if([self.title isEqualToString:@"Layout样式二"]){
    
        layout = [[XZCollectionLayoutStyleTwo alloc] init];
        
    }else if([self.title isEqualToString:@"Layout样式三"]){
    
        layout = [[XZCollectionLayoutStyleThree alloc] init];
    }
    
    _collectionView = ({
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [collectionView registerClass:[XZCollectionDemoCell class] forCellWithReuseIdentifier:@"MY_CELL"];
        
        
        if([self.title isEqualToString:@"Layout样式二"]){
            
            UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            [collectionView addGestureRecognizer:tapRecognizer];

        }
        
        collectionView;
    });
    
    [self.view addSubview:_collectionView];
}

#pragma mark UIGestureRecognizer
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:_collectionView];
        NSIndexPath* tappedCellPath = [_collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath!=nil)
        {
            _cellCount = _cellCount - 1;
            [_collectionView performBatchUpdates:^{
                
                [_collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
                
            } completion:nil];
        }
        else
        {
            _cellCount = _cellCount + 1;
            [_collectionView performBatchUpdates:^{
                [_collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            } completion:nil];
        }
    }
}

#pragma mark UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XZCollectionDemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    cell.backgroundColor = RandomColor;
    
    cell.textLabel.text = [NSString stringFromInt:indexPath.row];
    
    return cell;
    
}

@end
