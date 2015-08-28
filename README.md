# RateView

一个打分特效的view

使用步骤：

  1.导入视图：
  
    #import "DrawingView.h"
    
  2.创建对象：
  
    drawingView = [[DrawingView alloc]initWithFrame:CGRectMake(25, 100, [[UIScreen mainScreen] bounds].size.width - 50, [[UIScreen mainScreen] bounds].size.width - 50)];
    
    drawingView.delegate = self;
    
    drawingView.backgroundColor = [UIColor whiteColor];
    
    drawingView.percent = 0.0;
    
    drawingView.lineWidth = 10;
    
    [self.view addSubview:drawingView];
    
  3.设置属性：
  
    @property (nonatomic ,assign)CGFloat percent;
    
    @property (nonatomic ,assign)CGFloat lineWidth;
    
    percent指的是[0,1]的小数，默认0.5，数字越大表示微笑角度越大，0.5为面无表情，数字越接近0，表示越委屈，也就是利用percent进行运算得到打分结果
    
    lineWidth指的是线框宽度，默认宽度是5
    
  4.设置代理（可选）：
  
    遵守DrawingViewDelegate的协议，并实现-(void)drawingView:(DrawingView *)drawingView PercentChangeTo:(CGFloat)percent;
    
    当percent数值改变了，即回调该方法。
