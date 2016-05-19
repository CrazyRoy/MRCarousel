# Carousel
自定义轮播控件

四行代码完成轮播控件创建：

   1、导入头文件:        #import "MRPageView.h"
   2、初始化:            MRPageView *page = [MRPageView pageView];
   3、设置轮播的frame:   page.frame = CGRectMake(10, 50, 300, 130);
   4、设置数据源:        page.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
   
   其他设置: 
          1、更改轮播间隔时间:  page.time = 3.0;
          2、更改轮播默认角标颜色: page.tintColor = [UIColor whiteColor];
          3、更改轮播当前页角标颜色: page.currentColor = [UIColor orangeColor];
