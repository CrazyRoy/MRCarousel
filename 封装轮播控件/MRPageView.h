//
//  PageView.h
//  20150517
//
//  Created by SinObjectC on 16/5/17.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - MRPageView 声明文件

@protocol MRPageViewDataSource;

@protocol MRPageViewDelegate;

@interface MRPageView : UIView

/** 工厂方法 */
+ (instancetype)pageView;

///** 图片资源 */
//@property(nonatomic, strong)NSArray *imageNames;

/** 当前颜色 */
@property(nonatomic, strong)UIColor *currentColor;

/** 默认颜色 */
@property(nonatomic, strong)UIColor *tintColor;

/** 代理 */
@property(nonatomic, weak)id<MRPageViewDelegate> delegate;

/** 数据源 */
@property(nonatomic, weak)id<MRPageViewDataSource> dataSource;

/** 轮播间隔时间 */
@property(nonatomic, assign)NSTimeInterval time;

@end

#pragma mark - 轮播图片数据源

@protocol MRPageViewDataSource<NSObject>

@required

/**
 *	@brief	描述轮播图片的数量
 *
 *	@param 	pageView 	当前轮播控件对象
 *
 *	@return	数量
 */
- (NSInteger)pageViewOfPages:(MRPageView *)pageView;


/**
 *	@brief	返回对应下标的图片
 *
 *	@param 	pageView 	当前轮播控件对象
 *	@param 	index 	下标
 *
 *	@return	图片对象
 */
- (UIImage *)pageView:(MRPageView *)pageView imageForPageAtIndex:(NSInteger)index;

@end

#pragma mark - 轮播点击事件协议代理

@protocol MRPageViewDelegate<NSObject>

@optional

/**
 *	@brief	轮播图片点击
 */
- (void)pageView:(MRPageView *)pageView didSelectRowAtIndex:(NSInteger)index;

@end
