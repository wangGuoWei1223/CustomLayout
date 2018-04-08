//
//  GWCircleCollectionViewCell.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/28.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWCircleCollectionViewCell.h"

@implementation GWCircleCollectionViewCell

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat imageMarg = 10;
    self.imageView.frame = CGRectMake(imageMarg, imageMarg, self.frame.size.width - 2 * imageMarg, self.frame.size.height - 2 * imageMarg);

    self.titleLabel.frame = CGRectMake(0, self.frame.size.height * 0.5 - 15, self.frame.size.width, 30);
    
    
    
    
}

@end
