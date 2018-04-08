//
//  GWCollectionViewCell.h
//  自定义布局
//
//  Created by Gavin on 2018/3/22.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWCollectionViewCell : UICollectionViewCell

// 图片
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
/**
 初始化
 */
- (void)initUI;

- (void)showCellWithTitle:(NSString *)title;

@end
