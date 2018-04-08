//
//  GWBlockCollectionViewCell.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/27.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "GWBlockCollectionViewCell.h"
#import "UIColor+GWColor.h"

@implementation GWBlockCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
//
- (void)initUI {

    [super initUI];

    self.imageView.backgroundColor = [UIColor color_arc4random];
}

@end
