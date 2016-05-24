//
//  PageView.m
//  20150517
//
//  Created by SinObjectC on 16/5/17.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRPageView.h"


@interface MRPageView()<UIScrollViewDelegate>

/** 轮播view */
@property(nonatomic, strong)UIScrollView *scrollview;

/** 图片指示器 */
@property(nonatomic, strong)UIPageControl *control;

/** 定时器 */
@property(nonatomic, weak)NSTimer *timer;

@end


@implementation MRPageView

# pragma mark - 初始化方法

+ (instancetype)pageView {
    
    return [[MRPageView alloc] init];
    
}

///**
// *	@brief	设置图片资源
// *
// *	@param 	imageNames 	图片数组
// */
//- (void)setImageNames:(NSArray *)imageNames {
//    
//    _imageNames = imageNames;
//    
//    // 移除之前的所有的imageView
//    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    
//    for (int i = 0; i < imageNames.count; i++) {
//        // 创建
//        UIImageView *imageView = [[UIImageView alloc] init];
//        
//        imageView.image = [UIImage imageNamed:imageNames[i]];
//        
//        imageView.userInteractionEnabled = YES;
//        
//        imageView.tag = i;
//        
//        // 添加点击手势
//        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
//        
//        [imageView addGestureRecognizer:recognizer];
//        
//        [self.scrollview addSubview:imageView];
//    }
//    
//    // 设置总页数
//    self.control.numberOfPages = imageNames.count;
//}


/**
 *	@brief	设置数据源
 *
 *	@param 	dataSource
 */
- (void)setDataSource:(id<MRPageViewDataSource>)dataSource {
    
    _dataSource = dataSource;
    
    // 移除之前的所有的imageView
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 获得数据个数
    NSInteger count = [self.dataSource pageViewOfPages:self];
    
    for (int i = 0; i < count; i++) {
        // 创建
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = [self.dataSource pageView:self imageForPageAtIndex:i];
        
        imageView.userInteractionEnabled = YES;
        
        imageView.tag = i;
        
        // 添加点击手势
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        
        [imageView addGestureRecognizer:recognizer];
        
        [self.scrollview addSubview:imageView];
    }
    
    // 设置总页数
    self.control.numberOfPages = count;
}


/**
 *	@brief	currentColor设置器
 *
 *	@param 	currentColor 	当前页颜色
 */
- (void)setCurrentColor:(UIColor *)currentColor {

    _currentColor = currentColor;
    
    self.control.currentPageIndicatorTintColor = currentColor;
}


/**
 *	@brief	tintColor设置器
 *
 *	@param 	tintColor 	默认颜色
 */
- (void)setTintColor:(UIColor *)tintColor {
    
    _tintColor = tintColor;
    
    self.control.pageIndicatorTintColor = tintColor;
}


#pragma mark - 懒加载控件

- (UIScrollView *)scrollview {
    
    if(_scrollview == nil) {
        
        _scrollview = [[UIScrollView alloc] init];
        
        _scrollview.backgroundColor = [UIColor grayColor];
        
    }
    
    return _scrollview;
}


- (UIPageControl *)control {
    
    if(_control == nil) {
        
        _control = [[UIPageControl alloc] init];
        
        _control.currentPage = 0;
        
        _control.numberOfPages = 5;
        
        _control.hidesForSinglePage = YES;
        
        _control.currentPageIndicatorTintColor = [UIColor orangeColor];
        
        _control.tintColor = [UIColor grayColor];
    }
    
    return _control;
}


/**
 *	@brief	默认构造器
 *
 *	@param 	frame
 *
 *	@return	对象本身
 */
- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 添加子控件
        
        [self addSubview:self.scrollview];
        
        self.scrollview.showsHorizontalScrollIndicator = NO;
        
        // 取消弹簧效果
        self.scrollview.bounces = NO;
        
        // 设置代理
        self.scrollview.delegate = self;
        
        // 设置可以分页
        self.scrollview.pagingEnabled = YES;
        
        [self addSubview:self.control];
        
        [self setup];
    }
    
    return self;
}


/**
 *	@brief	初始化相关设置
 */
- (void)setup {
    
    // 设置背景颜色等
    
    // 设置默认时间间隔
    self.time = 1.5;

    // 启动计时任务
    [self startTimer];
    
}

/**
 *	@brief	轮播图片的点击手势处理
 *
 *	@param 	sender 	手势
 */
- (void)imageClick:(UIGestureRecognizer *)sender {

    // 调用代理的方法
    if([self.delegate respondsToSelector:@selector(pageView:didSelectRowAtIndex:)]) {
        [self.delegate pageView:self didSelectRowAtIndex:sender.view.tag];
    }
    
}


# warning 只要外部改变 frame 就会调用这个方法, 并且不是立刻改变，因为消息循环机制，会在所在方法块结束之后
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 设置scrollView的frame
    self.scrollview.frame = self.bounds;
    
    // 获得ScrollView的尺寸
    CGFloat scrollW = self.scrollview.frame.size.width;
    CGFloat scrollH = self.scrollview.frame.size.height;
    
    // 设置UIPageControl
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = scrollW - pageW;
    CGFloat pageY = scrollH - pageH;
    
    self.control.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    int count = self.scrollview.subviews.count;
    
    // 设置内容大小
    self.scrollview.contentSize = CGSizeMake(count * scrollW, 0);
    
    for (int i = 0; i < count; i++) {

        // 取出控件设置frame
        UIImageView *imageView = self.scrollview.subviews[i];
      
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
}


# pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width + 0.5);
    
    self.control.currentPage = page;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
    
}


# pragma mark - 定时器控制

/**
 *	@brief	开启定时器任务
 */
- (void)startTimer {
    
    // 创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    // 将定时器任务添加到主消息循环中去，并且告诉主消息循环为通用模式，让定时器任何和主线程优先级差不多一起执行
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


/**
 *	@brief	停止定时器任务
 */
- (void)stopTimer {
    
    [self.timer invalidate];
    
    self.timer = nil;

}


/**
 *	@brief	跳转到下一页
 */
- (void)nextPage {

    int page = self.control.currentPage + 1;
    
    if(page == self.control.numberOfPages) {    // 到达最后一页
        
        page = 0;
        
    }
    
    CGPoint offSet = self.scrollview.contentOffset;
    
    offSet.x = page * self.scrollview.frame.size.width;
    
    [self.scrollview setContentOffset:offSet animated:YES];
    
}
@end
