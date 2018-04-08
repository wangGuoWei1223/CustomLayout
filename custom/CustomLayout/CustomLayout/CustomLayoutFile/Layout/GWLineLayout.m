//
//  GWLineLayout.m
//  自定义布局
//
//  Created by Gavin on 2018/3/22.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWLineLayout.h"

@implementation GWLineLayout

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         UICollectionViewLayoutAttributes *atts;
         1. 一个cell 对应一个 UICollectionViewLayoutAttributes 对象
         2. UICollectionViewLayoutAttributes对象决定cellframe
         
         */
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/**
 当 collectionView的显示内容发生变化的时候，是否需要重新刷新布局
 一旦重新布局，就会重新调用
 
 1、prepareLayout
 2、layoutAttributesForElementsInRect:方法

 @param newBounds 最新显示区域
 @return 是否调用上面两个方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return true;
}

/**
 用来布局初始化（不建议在init中初始化）
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
/**
 这个方法返回一个数组（数组中放着rect内所有元素的布局属性）
 这个方法决定了rect中所有元素是排布frame

 @param rect 内容区域
 @return 布局属性数组
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 加上collectionView 最中心点x的位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 在原来的布局基础上进行微调
    for (UICollectionViewLayoutAttributes *atts in array) {
        
        // cell 的中心店的 x 与 collectionView 最中心点x的 间距
        CGFloat delta = ABS(atts.center.x - centerX);
        
        //  根据距离  计算cell 的缩放比例
        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
        atts.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    
    return array;
    
}

/**
 这个方法的返回值，决定了 collectionView停止滚动时的偏移量

 @param proposedContentOffset 目标偏移量
 @param velocity 速度
 @return 最终偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    // 最终显示的矩形框
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;

    // 获取 rect 框中super 已经计算好的的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算 collectionView 的最中心的位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 存放最小差值
    CGFloat minDetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *atts in array) {
        if (ABS(minDetal) > ABS(atts.center.x - centerX)) {
            minDetal = atts.center.x - centerX;
        }
    }
   
    // 修改原始的偏移量
    proposedContentOffset.x += minDetal;
    return proposedContentOffset;

}


@end
