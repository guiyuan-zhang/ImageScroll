//
//  ZGYAutoScroll.m
//  ImageScroll
//
//  Created by zgy on 16/3/30.
//  Copyright © 2016年 800best. All rights reserved.
//

#import "ZGYAutoScroll.h"



#define vWidth self.frame.size.width
#define vHeight self.frame.size.height

@interface ZGYAutoScroll ()<UIScrollViewDelegate>{
    NSTimer *_timer;
}

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSMutableArray *imagsArray;

@end

@implementation ZGYAutoScroll

- (instancetype)initWithFrame:(CGRect)frame andImageS:(NSArray *)imageS {
    if (self = [super initWithFrame:frame]) {
        if (imageS.count != 0) {
            self.images = imageS;
            [self setScrollView];
            [self setPageControl];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
        }
    }
    return self;
}

- (void)setScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.delegate = self;
    self.imagsArray = [NSMutableArray arrayWithArray:_images];
    [self.imagsArray insertObject:_images.lastObject atIndex:0];
    for (int i = 0; i < self.imagsArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(vWidth * i, 0, vWidth, vHeight)];
        imageView.image = self.imagsArray[i];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(vWidth * self.imagsArray.count, vHeight);
    self.scrollView.contentOffset = CGPointMake(vWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
}

- (void)setImages:(NSArray *)images{
    _images = images;
}

- (void)setTime:(NSTimeInterval)time{
    if (time != 0) {
        [_timer invalidate];
        _timer = nil;
        
        _time = time;
        [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    }
    
}

- (void)setSetPageIndicatorTintColor:(UIColor *)setPageIndicatorTintColor{
    if (setPageIndicatorTintColor) {
        _setPageIndicatorTintColor = setPageIndicatorTintColor;
        self.pageControl.pageIndicatorTintColor = _setPageIndicatorTintColor;
    }
    
}

- (void)setSetCurrentPageIndicatorTintColor:(UIColor *)setCurrentPageIndicatorTintColor{
    if (setCurrentPageIndicatorTintColor) {
        _setCurrentPageIndicatorTintColor = setCurrentPageIndicatorTintColor;
        self.pageControl.currentPageIndicatorTintColor = _setCurrentPageIndicatorTintColor;
    }
}
// 设置pageControl
- (void)setPageControl{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(vWidth/10, vHeight/6*5, vWidth - vWidth/5, vHeight/10)];
    self.pageControl.numberOfPages = self.imagsArray.count - 1;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.pageControl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
}

- (void)valueChange:(UIPageControl *)sender{
    NSInteger page = sender.currentPage;
    CGFloat x = (page + 1) *vWidth; //根据当前点计算出scrollView的偏移量
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if (x > (self.imagsArray.count - 1)*vWidth) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    if (x < 0) {
        [scrollView setContentOffset:CGPointMake((self.imagsArray.count - 1) *vWidth, 0) animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger page = x/vWidth - 1;
    if (page < 0) {
        _pageControl.currentPage = self.imagsArray.count - 1;
    }else{
        _pageControl.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger page = x/vWidth - 1;
    if (page < 0) {
        _pageControl.currentPage = self.imagsArray.count - 1;
    }else{
        _pageControl.currentPage = page;
    }
}

#pragma mark --设置定时器自动轮播
- (void)autoPlay{
    CGFloat x = _scrollView.contentOffset.x;
    if (x + vWidth >= _scrollView.contentSize.width) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [_scrollView setContentOffset:CGPointMake(vWidth, 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(x + vWidth, 0) animated:YES];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
