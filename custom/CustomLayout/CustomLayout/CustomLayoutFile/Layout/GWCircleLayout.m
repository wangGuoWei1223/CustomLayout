//
//  GWCircleLayout.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/28.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWCircleLayout.h"

@interface GWCircleLayout()
/** 布局属性数组 */
@property (nonatomic, strong)NSMutableArray *attrsArray;
@end
@implementation GWCircleLayout

/**
 初始化操作
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:atts];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArray;
}
/**
 返回对象indexPath 的item的布局

 @param indexPath 对应的位置
 @return 布局属性
 // 再切换布局时需要实现这个方法，否则会崩溃。
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    // collectionView 的中心点
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
    CGFloat radius = 100.0; // 半径
    
    UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    atts.size = CGSizeMake(80, 80);
    // 每个cell的中心点坐标
    if (count == 1) { // 只有一个cell 时
        atts.center = CGPointMake(oX, oY);
    }else {
        
        CGFloat angle = 2.0 * M_PI / count; // 角度
        CGFloat centerX = oX + radius * sin(indexPath.item * angle);
        CGFloat centerY = oY + radius * cos(indexPath.item * angle);
        atts.center = CGPointMake(centerX, centerY);
    }
    
    return  atts;
}



#pragma mark - 懒加载
/** 布局属性数组 */
- (NSMutableArray *)attrsArray {
    
    if(!_attrsArray) {
        
        _attrsArray = [NSMutableArray new];
    }
    
    return _attrsArray;
}

@end
