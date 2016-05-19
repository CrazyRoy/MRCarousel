//
//  PageView.h
//  20150517
//
//  Created by SinObjectC on 16/5/17.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 轮播点击事件协议代理

@protocol MRPageViewDelegate<NSObject>

@optional

/**
 *	@brief	轮播图片点击
 */
- (void)pageViewClick:(int) pageIndex;

@end


#pragma mark - MRPageView 声明文件

@interface MRPageView : UIView

/** 工厂方法 */
+ (instancetype)pageView;

/** 图片资源 */
@property(nonatomic, strong)NSArray *imageNames;

/** 当前颜色 */
@property(nonatomic, strong)UIColor *currentColor;

/** 默认颜色 */
@property(nonatomic, strong)UIColor *tintColor;

/** 代理 */
@property(nonatomic, weak)id<MRPageViewDelegate> delegate;

/** 轮播间隔时间 */
@property(nonatomic, assign)NSTimeInterval time;


@end
