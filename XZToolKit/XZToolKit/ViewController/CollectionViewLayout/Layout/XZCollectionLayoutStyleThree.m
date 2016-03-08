//
//  XZCollectionLayoutStyleThree.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCollectionLayoutStyleThree.h"

@implementation XZCollectionLayoutStyleThree
{
    
    NSInteger _numberOfCell;
    CGSize _largeSize;
    CGSize _smallSize;
    
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    _numberOfCell = [self.collectionView numberOfItemsInSection:0];
    
    _largeSize = CGSizeMake(UISCREEN_WIDTH*2/3, UISCREEN_WIDTH*2/3);
    _smallSize = CGSizeMake(_largeSize.width/2, _largeSize.height/2);
    
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing =0.0f;
    
}

- (CGSize)collectionViewContentSize{
    
    CGFloat line = _numberOfCell/3.0;
    
    NSInteger row = ceil(line);
    
    CGSize size = CGSizeMake(UISCREEN_WIDTH, UISCREEN_WIDTH*2/3*row + 64);
    
    return size;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<_numberOfCell; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger row = indexPath.row/3;
    
    CGRect rect;
    
    if (row%2 == 1) {
        //奇数行
        
        if (indexPath.row%3 == 0) {
            
            rect = CGRectMake(0, _largeSize.height*row,_smallSize.width, _smallSize.height);
            
        }else if(indexPath.row%3 == 1){
            
            rect = CGRectMake(0, _largeSize.height*row+_smallSize.height, _smallSize.width, _smallSize.height);
        }
        else if(indexPath.row%3 == 2){
            
            rect = CGRectMake(_smallSize.width, _largeSize.height*row, _largeSize.width, _largeSize.height);
        }
        
    }else{
        //偶数行
        if (indexPath.row%3 == 0) {
            
            rect = CGRectMake(0, _largeSize.height * row, _largeSize.width, _largeSize.height);
            
            
        }else if(indexPath.row%3 == 1){
            
            rect = CGRectMake(_largeSize.width, _largeSize.height *row, _smallSize.width, _smallSize.height);
        }
        else if(indexPath.row%3 == 2){
            
            rect = CGRectMake(_largeSize.width, _largeSize.height*row + _smallSize.height, _smallSize.width, _smallSize.height);
        }
        
    }
    
    attribute.frame = rect;

    return attribute;
}
@end
