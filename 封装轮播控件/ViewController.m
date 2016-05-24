//
//  ViewController.m
//  分页
//
//  Created by SinObjectC on 16/5/17.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "ViewController.h"
#import "MRPageView.h"

@interface ViewController ()<MRPageViewDataSource, MRPageViewDelegate>

@property(nonatomic, strong)MRPageView *page;

/** 图片数组 */
@property(nonatomic, strong)NSArray *images;

@end

@implementation ViewController

- (NSArray *)images {
    
    if(_images == nil) {
        
        _images = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    }
    
    return _images;
}


// 懒加载创建轮播控件
- (MRPageView *)page {
    
    if(_page == nil) {
        
        _page = [MRPageView pageView];
        
//        _page.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
        
        _page.currentColor = [UIColor orangeColor];
        
        _page.tintColor = [UIColor whiteColor];
        
        _page.frame = CGRectMake(10, 50, 300, 130);
        
    }
    
    return _page;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置数据源
    self.page.dataSource = self;
    
    // 设置代理
    self.page.delegate = self;
    
    [self.view addSubview:self.page];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - <MRPageViewDataSource>

- (NSInteger)pageViewOfPages:(MRPageView *)pageView {
    
    return self.images.count;
}

- (UIImage *)pageView:(MRPageView *)pageView imageForPageAtIndex:(NSInteger)index {
    
    UIImage *image = [UIImage imageNamed:self.images[index]];
                      
    return image;
}

# pragma mark - <MRPageViewDelegte>

- (void)pageView:(MRPageView *)pageView didSelectRowAtIndex:(NSInteger)index {
    
    NSLog(@"点击图片----%i", index);
}

@end
