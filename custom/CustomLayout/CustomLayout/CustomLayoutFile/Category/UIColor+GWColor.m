//
//  UIColor+GWColor.m
//  CustomLayout
//
//  Created by niuwan on 2018/3/27.
//  Copyright © 2018年 BLSDZ. All rights reserved.
//

#import "UIColor+GWColor.h"

@implementation UIColor (GWColor)

/**
 随机色 生成一个颜色

 @return 随机颜色
 */
+ (UIColor *)color_arc4random {
    
    CGFloat r = arc4random_uniform(256)/ 255.0;
    CGFloat g = arc4random_uniform(256)/ 255.0;
    CGFloat b = arc4random_uniform(256)/ 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
