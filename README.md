# Carousel

##自定义轮播控件

- **四行代码完成轮播控件创建：**

   - 1.导入文件之后再引入头文件
   
                           #import "MRPageView.h"
   
   - 2.初始化
      
                           MRPageView *page = [MRPageView pageView];
   
   - 3.设置轮播的frame
      
                           page.frame = CGRectMake(10, 50, 300, 130);
   
- **其他设置: **
   - 1.更改轮播间隔时间:  page.time = 3.0;
          
   - 2.更改轮播默认角标颜色: page.tintColor = [UIColor whiteColor];
          
   - 3.更改轮播当前页角标颜色: page.currentColor = [UIColor orangeColor];
   

- **示例代码:**

```objc
   // 懒加载创建轮播控件
- (MRPageView *)page {
    
    if(_page == nil) {
        
        _page = [MRPageView pageView];
          
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

```
   
- **简单效果图:**
   
   ![image](https://github.com/Andrew554/Carousel/blob/master/%E8%87%AA%E5%AE%9A%E4%B9%89%E8%BD%AE%E6%92%AD%E6%8E%A7%E4%BB%B6.gif)
   
