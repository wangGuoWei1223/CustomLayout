//
//  GWCollectionViewCell.m
//  自定义布局
//
//  Created by Gavin on 2018/3/22.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWCollectionViewCell.h"

@interface GWCollectionViewCell()



@end;

@implementation GWCollectionViewCell

- (void)showCellWithTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.layer.masksToBounds = true;
    imageView.layer.cornerRadius = 5.0;
//    CGFloat imageMarg = 10;
//    imageView.frame = CGRectMake(imageMarg, imageMarg, self.contentView.frame.size.width - 2 * imageMarg, self.contentView.frame.size.height - 2 * imageMarg);
    self.imageView = imageView;
    
    UILabel *titleLabel = [UILabel new];
//    titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
   
    self.titleLabel = titleLabel;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageMarg = 10;
    self.imageView.frame = CGRectMake(imageMarg, imageMarg, self.contentView.frame.size.width - 2 * imageMarg, self.contentView.frame.size.height - 2 * imageMarg);
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    self.titleLabel.center = self.contentView.center;
    
}

@end
