//
//  XZImageBrowserLayout.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/27.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageBrowserLayout.h"
#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3

@implementation XZImageBrowserLayout

- (id)init{
    
    self = [super init];
    
    if (self) {
        
//        self.itemSize = CGSizeMake(UISCREEN_WIDTH*0.7,UISCREEN_HEIGHT*0.7);
        
        self.itemSize = CGSizeMake(200, 200);
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        self.sectionInset = UIEdgeInsetsMake((UISCREEN_HEIGHT - self.itemSize.height)/2, (UISCREEN_WIDTH - self.itemSize.width)/2, (UISCREEN_HEIGHT - self.itemSize.height)/2, (UISCREEN_WIDTH - self.itemSize.width)/2);
        
        self.minimumLineSpacing = (UISCREEN_WIDTH - self.itemSize.width)/2;
//        self.minimumInteritemSpacing = 0.0f;
        
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    NSArray *tmpArray = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in tmpArray) {
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            
            if (ABS(distance) < ACTIVE_DISTANCE) {
                
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return tmpArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGFloat offsetAdjustment = MAXFLOAT;
    
    XZFloatLog(proposedContentOffset.x);
    
    CGFloat horizontalCenter = proposedContentOffset.x + UISCREEN_WIDTH/2;
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0,UISCREEN_WIDTH, UISCREEN_HEIGHT);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        
    
        CGFloat center_x = attributes.center.x;
        
        if (fabs(center_x - horizontalCenter) < fabs(offsetAdjustment)) {
            
            offsetAdjustment = center_x - horizontalCenter;
        }
        
    }
    
    XZFloatLog(offsetAdjustment);
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
