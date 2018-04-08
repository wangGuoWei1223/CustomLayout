//
//  GWWaterLayout.m
//  CustomLayout
//
//  Created by Gavin on 2018/3/29.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWWaterLayout.h"

// 默认的列数
static const NSInteger GWDefaultColumnCount = 3;
// 每一列之间的间距
static const CGFloat GWDefaultColumnMargin = 10;
// 每一行之间的间距
static const CGFloat GWDefaultRowMargin = 10;
// 边缘间距
static const UIEdgeInsets GWDefaultEdgeInsets = {10, 10, 10, 10};

@interface GWWaterLayout()
// 布局属性数组
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
// 存放所有列的最多Y值
@property (nonatomic, strong) NSMutableArray<NSNumber *> *allMaxYs;

#pragma mark - 常见数据设置
- (NSInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation GWWaterLayout

/**
 * 初始化操作
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 清除之情的最大Y值
    [self.allMaxYs removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        // 设置默认的高度
        [self.allMaxYs addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 创建每个cell对应的布局
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 获取indexpath位置对应的cell的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
}

/**
 *决定cell的布局

 @param rect 区域
 @return 布局属性数组
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attrsArray;
}

/**
 *在指定indexPath位置item的布局

 @param indexPath 指定的位置
 @return 布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    // 设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    // 从外界获取高度
    CGFloat h = [self.delegate waterLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的列
    NSInteger destColumn = 0; // 目标列
    // 默认第一列最短 这样可以少循环一次 优化性能
    CGFloat minColumnHeight = [self.allMaxYs[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取出第i列的高度
        CGFloat columnHeight = self.allMaxYs[i].doubleValue;
        if (minColumnHeight > columnHeight) {
            // 记录最小值 和 目标列
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        /* 不是第一行加上 行间距 第一行不需要行间距 */
        y += self.rowMargin;
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短列的高度
    self.allMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

/**
 *决定collectionView的滚动范围

 @return 范围
 */
- (CGSize)collectionViewContentSize {
    
    // 最大 高度  默认第一列 最高
    CGFloat maxColumnHeight = [self.allMaxYs[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取出第i列的高度
        CGFloat columnHeight = self.allMaxYs[i].doubleValue;
        if (maxColumnHeight < columnHeight) {
            // 记录最大值
            maxColumnHeight = columnHeight;
        }
    }
    // 确认 滚动范围
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}

#pragma mark - 常见数据设置
- (NSInteger)columnCount {
    
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterLayout:)]) {
        return [self.delegate columnCountInWaterLayout:self];
    }else {
        
        return GWDefaultColumnCount;
    }
}
- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterLayout:)]) {
        return [self.delegate columnMarginInWaterLayout:self];
    }else {
        
        return GWDefaultColumnMargin;
    }
}

- (CGFloat)rowMargin {
    
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterLayout:)]) {
        return [self.delegate rowMarginInWaterLayout:self];
    }else {
        
        return GWDefaultRowMargin;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterLayout:)]) {
        return [self.delegate edgeInsetsInWaterLayout:self];
    }else {
        
        return GWDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
// 布局属性数组
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrsArray {
    
    if (_attrsArray == nil) {
        
        _attrsArray = [NSMutableArray new];
    }
    
    return _attrsArray;
}
// 存放所有列的最多Y值
- (NSMutableArray<NSNumber *> *)allMaxYs {
    
    if (_allMaxYs == nil) {
        
        _allMaxYs = [NSMutableArray new];
    }
    
    return _allMaxYs;
}

@end
