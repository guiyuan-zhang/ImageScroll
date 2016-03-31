//
//  ZGYAutoScroll.h
//  ImageScroll
//
//  Created by zgy on 16/3/30.
//  Copyright © 2016年 800best. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGYAutoScroll : UIView
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) UIColor *setPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *setCurrentPageIndicatorTintColor;
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame andImageS:(NSArray *)imageS;

//提供自定义设置时间的接口
- (void)setImages:(NSArray *)images;
//设置小圆点的颜色接口
- (void)setSetPageIndicatorTintColor:(UIColor *)setPageIndicatorTintColor;
- (void)setSetCurrentPageIndicatorTintColor:(UIColor *)setCurrentPageIndicatorTintColor;
@end
