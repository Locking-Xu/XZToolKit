//
//  XZLabelFlowLayout.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/28.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowLayout.h"
#import "XZUtils.h"
#import "XZLabelFlowConfig.h"

typedef struct currentOrigin{

    CGFloat lineX;
    NSInteger lineNumber;
}currentOrigin;

@implementation XZLabelFlowLayout{

    UIEdgeInsets _contentInsets;
    CGFloat _textMargin;
    CGFloat _itemSpace;
    CGFloat _lineSpace;
    CGFloat _textFont;
    CGFloat _textHeight;
    currentOrigin _orgin;
}

- (void)prepareLayout{

    XZLabelFlowConfig *config = [XZLabelFlowConfig shareInstance];
    _contentInsets = config.contentInsets;
    _textMargin = config.textMargin;
    _itemSpace = config.itemSpace;
    _lineSpace = config.lineSpace;
    _textFont = config.textFont;
    _textHeight = config.textHeight;
    _orgin.lineNumber = 0;
    _orgin.lineX = _contentInsets.left;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    NSArray *array = [[NSArray alloc] initWithArray:attributesArray copyItems:YES];
    
    for (NSInteger i=0; i<array.count; i++) {
        
        UICollectionViewLayoutAttributes *attribute = array[i];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        NSString *title = [self.dataSource titleAtIndexPath:indexPath];
        
        CGSize size = [XZUtils stringAdaptive:title height:_textHeight lineSpace:0 font:_textFont mode:NSLineBreakByCharWrapping];
        
        CGFloat itemOrginX = _orgin.lineX;
        CGFloat itemOrginY = _orgin.lineNumber*(20.0f+_lineSpace)+_contentInsets.top;
        CGFloat itemWidth = size.width+_textMargin*2;
        
        if (itemWidth > CGRectGetWidth(self.collectionView.frame) - _contentInsets.left - _contentInsets.right) {
            itemWidth = CGRectGetWidth(self.collectionView.frame) - _contentInsets.left - _contentInsets.right;
        }
        
        attribute.frame = CGRectMake(itemOrginX, itemOrginY, itemWidth, _textHeight);
        
        _orgin.lineX += itemWidth + _itemSpace;
        
        if (i<array.count -1) {
            
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:i+1 inSection:0];
            NSString *nextTitle = [self.dataSource titleAtIndexPath:nextIndexPath];
            CGSize nextSize = [XZUtils stringAdaptive:nextTitle height:_textHeight lineSpace:0 font:_textFont mode:NSLineBreakByCharWrapping];
            if (nextSize.width + 2*_textMargin > CGRectGetWidth(self.collectionView.frame) - _contentInsets.right - _orgin.lineX) {
                
                _orgin.lineNumber++;
                _orgin.lineX = _contentInsets.left;
            }
        }else{
        
            [self.delegate layoutFinishWithLineNumber:_orgin.lineNumber+1];
        }
    }
        
        
    
    return array;
}

@end
