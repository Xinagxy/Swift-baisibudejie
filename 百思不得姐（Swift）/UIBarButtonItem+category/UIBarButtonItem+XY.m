//
//  UIBarButtonItem+XY.m
//  YiTong
//
//  Created by 尧的mac on 16/4/13.
//  Copyright © 2016年 xxy.icom. All rights reserved.
//

#import "UIBarButtonItem+XY.h"

@implementation UIBarButtonItem (XY)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+ (UIBarButtonItem *)itemWithString:(NSString *)string selectedColor:(UIColor *)selectedColor target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, CGSizeMake(40, 30)};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
@end
