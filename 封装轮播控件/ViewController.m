//
//  ViewController.m
//  分页
//
//  Created by SinObjectC on 16/5/17.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "ViewController.h"
#import "MRPageView.h"

@interface ViewController ()<MRPageViewDelegate>

@property(nonatomic, strong)MRPageView *page;

@end

@implementation ViewController

// 懒加载
- (MRPageView *)page {
    
    if(_page == nil) {
        
        _page = [MRPageView pageView];
        
        _page.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
        
        _page.currentColor = [UIColor orangeColor];
        
        _page.tintColor = [UIColor whiteColor];
        
        _page.frame = CGRectMake(10, 50, 300, 130);
        
    }
    
    return _page;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置代理
    self.page.delegate = self;
    
    [self.view addSubview:self.page];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pageViewClick:(int)pageIndex {
    
    NSLog(@"number -- %i", pageIndex);
}

@end
