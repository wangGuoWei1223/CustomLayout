 //
//  GWBlockLayout.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/27.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//  自定义布局

#import "GWBlockLayout.h"

@interface GWBlockLayout()
@property (nonatomic, strong)NSMutableArray *attrsArray;
@end

@implementation GWBlockLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 获取collectionView 中第一分区item的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    [self.attrsArray removeAllObjects];
    // 自定义属性
    for (NSInteger i = 0; i < count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat width = self.collectionView.frame.size.width * 0.5;
        if (i == 0) {
            
            CGFloat height = width;
            CGFloat x = 0;
            CGFloat y = 0;
            atts.frame = CGRectMake(x, y, width, height);
        }else if (i == 1) {
            
            CGFloat height = width * 0.5;
            CGFloat x = width;
            CGFloat y = 0;
            atts.frame = CGRectMake(x, y, width, height);
        }else if (i == 2) {
            
            CGFloat height = width * 0.5;
            CGFloat x = width;
            CGFloat y = height;
            atts.frame = CGRectMake(x, y, width, height);
        }else if (i == 3) {
            
            CGFloat height = width * 0.5;
            CGFloat x = 0;
            CGFloat y = width;
            atts.frame = CGRectMake(x, y, width, height);
        }else if (i == 4) {
            
            CGFloat height = width * 0.5;
            CGFloat x = 0;
            CGFloat y = width + height;
            atts.frame = CGRectMake(x, y, width, height);
        }else if (i == 5) {
            
            CGFloat height = width;
            CGFloat x = width;
            CGFloat y = width;
            atts.frame = CGRectMake(x, y, width, height);
        }else {
            UICollectionViewLayoutAttributes *lastAtts = self.attrsArray[i - 6];
            CGRect lastFrame = lastAtts.frame;
            lastFrame.origin.y += 2 * width; // 利用上面的frame
            //
            atts.frame = lastFrame;
        }
        
        // 添加布局属性
        [self.attrsArray addObject:atts];
    }
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 创建数组
//    NSMutableArray *array = [NSMutableArray new];
//
//    // 获取collectionView 中第一分区item的个数
//    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//
//    // 自定义属性
//    for (NSInteger i = 0; i < count; i++) {
//
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        CGFloat width = self.collectionView.frame.size.width * 0.5;
//        if (i == 0) {
//
//            CGFloat height = width;
//            CGFloat x = 0;
//            CGFloat y = 0;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else if (i == 1) {
//
//            CGFloat height = width * 0.5;
//            CGFloat x = width;
//            CGFloat y = 0;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else if (i == 2) {
//
//            CGFloat height = width * 0.5;
//            CGFloat x = width;
//            CGFloat y = height;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else if (i == 3) {
//
//            CGFloat height = width * 0.5;
//            CGFloat x = 0;
//            CGFloat y = width;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else if (i == 4) {
//
//            CGFloat height = width * 0.5;
//            CGFloat x = 0;
//            CGFloat y = width + height;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else if (i == 5) {
//
//            CGFloat height = width;
//            CGFloat x = width;
//            CGFloat y = width;
//            atts.frame = CGRectMake(x, y, width, height);
//        }else {
//            UICollectionViewLayoutAttributes *lastAtts = array[i - 6];
//            CGRect lastFrame = lastAtts.frame;
//            lastFrame.origin.y += 2 * width; // 利用上面的frame
//            //
//            atts.frame = lastFrame;
//        }
//
//        // 添加布局属性
//        [array addObject:atts];
//    }
    
    // 返回计算好的属性数组
    return self.attrsArray;
}

/**
 返回collectionView的内容大小

 @return 内容大小
 */
- (CGSize)collectionViewContentSize {
    
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    // 计算行数
    int row = (count + 3 - 1) / 3;
    
    CGFloat rowH = self.collectionView.frame.size.width * 0.5;
    // 内容大小
    return CGSizeMake(self.collectionView.frame.size.width, row * rowH);
}

#pragma mark - 懒加载
/** 属性数组 */
- (NSMutableArray *)attrsArray {
    
    if(!_attrsArray) {
        
        _attrsArray = [NSMutableArray new];
    }
    
    return _attrsArray;
}

@end
