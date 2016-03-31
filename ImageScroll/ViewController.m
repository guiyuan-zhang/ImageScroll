//
//  ViewController.m
//  ImageScroll
//
//  Created by zgy on 16/3/15.
//  Copyright © 2016年 800best. All rights reserved.
//

#import "ViewController.h"
#import "ZGYAutoScroll.h"

@interface ViewController ()
//@property (nonatomic, strong)NSMutableArray *imageArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *imageArray = [NSMutableArray array];
    ZGYAutoScroll *zgy = [[ZGYAutoScroll alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200) andImageS:[self setImageArray:imageArray]];
    zgy.backgroundColor = [UIColor blueColor];
    [self.view addSubview:zgy];
//    [zgy setTime:3.0];    //  zgy.time = 3.0;   默认是1秒   可以自己设置时间
    
}


- (NSMutableArray *)setImageArray:(NSMutableArray *)imageArray{
    for (int i = 1; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_00%D.JPG",i]];
        [imageArray addObject:image];
    }
    return imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
