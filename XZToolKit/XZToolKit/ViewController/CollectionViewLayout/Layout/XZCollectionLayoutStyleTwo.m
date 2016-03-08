//
//  XZCollectionLayoutStyleTwo.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCollectionLayoutStyleTwo.h"

@implementation XZCollectionLayoutStyleTwo
{
    
    NSInteger _cellCount;
    CGPoint _center;
    CGFloat _radius;
    NSMutableArray *_insertIndexPaths;
    NSMutableArray *_deleteIndexPaths;
}

- (void)prepareLayout{
    
    CGSize size = self.collectionView.bounds.size;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _center = CGPointMake(size.width/2.0, size.height/2.0);
    _radius = MIN(size.width, size.height)/2.0;
}

- (CGSize)collectionViewContentSize{
    
    return self.collectionView.bounds.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = CGSizeMake(70, 70);
    attribute.center = CGPointMake(_center.x + _radius * cosf(2 * indexPath.item * M_PI / _cellCount),
                                   _center.y + _radius * sinf(2 * indexPath.item * M_PI / _cellCount));
    
    
    return attribute;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSInteger i = 0; i< _cellCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    
    [super prepareForCollectionViewUpdates:updateItems];
    _insertIndexPaths = [NSMutableArray array];
    _deleteIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems) {
        
        if (update.updateAction == UICollectionUpdateActionDelete) {
            
            [_deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }else if (update.updateAction == UICollectionUpdateActionInsert){
            
            [_insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    
    UICollectionViewLayoutAttributes *attribute = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath] ;
    if ([_insertIndexPaths containsObject:itemIndexPath]) {
        
        if (!attribute)
            attribute = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attribute.alpha = 0.0;
        attribute.center = CGPointMake(_center.x, _center.y);
    }
    
    return attribute;
    
}


- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([_deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.center = CGPointMake(_center.x, _center.y);
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}

@end
