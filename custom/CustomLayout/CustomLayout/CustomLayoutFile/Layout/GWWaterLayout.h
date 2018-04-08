//
//  GWWaterLayout.h
//  CustomLayout
//
//  Created by Gavin on 2018/3/29.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//  瀑布流布局

#import <UIKit/UIKit.h>

@class GWWaterLayout;
@protocol GWWaterLayoutDelegate <NSObject>

@required
/**
 每一个item的高度

 @param waterLayout 布局属性
 @param index 索引
 @param itemWidth 当前item的宽度
 @return 计算好的高度
 */
- (CGFloat)waterLayout:(GWWaterLayout *)waterLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/**
 列数

 @param waterLayout 布局属性
 @return 列数
 */
- (NSInteger)columnCountInWaterLayout:(GWWaterLayout *)waterLayout;

/**
 列间距

 @param waterLayout 布局属性
 @return 列间距
 */
- (CGFloat)columnMarginInWaterLayout:(GWWaterLayout *)waterLayout;

/**
 行间距

 @param waterLayout 布局属性
 @return 行间距
 */
- (CGFloat)rowMarginInWaterLayout:(GWWaterLayout *)waterLayout;

/**
 边缘间距

 @param waterLayout 布局属性
 @return 边缘间距
 */
- (UIEdgeInsets)edgeInsetsInWaterLayout:(GWWaterLayout *)waterLayout;

@end

@interface GWWaterLayout : UICollectionViewLayout

// 代理
@property (nonatomic, weak) id<GWWaterLayoutDelegate> delegate;

@end
