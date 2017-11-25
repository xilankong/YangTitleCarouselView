//
//  ViewController.m
//  YangTitleCarouselView
//
//  Created by yanghuang on 2017/11/25.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "ViewController.h"
#import "TitleCarouselView.h"

@interface ViewController ()
@property (nonatomic, strong) TitleCarouselView *titleCarouselView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleCarouselView = [[TitleCarouselView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44)];
    [self.view addSubview:self.titleCarouselView];
    self.titleCarouselView.backgroundColor = [UIColor redColor];
    [self.titleCarouselView updateWithArray:@[@"【测试标签】测试数据123456789123456789",@"【测试标签2】测试数据-----------------------"]];
}

@end
