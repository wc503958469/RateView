//
//  RateViewController.m
//  ben500
//
//  Created by wangchen on 15/8/27.
//  Copyright (c) 2015年 com.ben500. All rights reserved.
//

#import "RateViewController.h"
#import "DrawingView.h"

@interface RateViewController ()<DrawingViewDelegate>{
    DrawingView *drawingView ;
    UILabel *label;
    
    UISlider *slider;
}
@property (nonatomic,assign)CGFloat percent;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    drawingView = [[DrawingView alloc]initWithFrame:CGRectMake(25, 100, [[UIScreen mainScreen] bounds].size.width - 50, [[UIScreen mainScreen] bounds].size.width - 50)];
    drawingView.delegate = self;
    drawingView.backgroundColor = [UIColor whiteColor];
//    drawingView.percent = 0.0;
    drawingView.lineWidth = 10;
    [self.view addSubview:drawingView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(drawingView.frame)+ 20, [[UIScreen mainScreen] bounds].size.width, 50)];
    label.text = [NSString stringWithFormat:@"0.5"];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    slider = [[UISlider alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(label.frame)+ 20, [[UIScreen mainScreen] bounds].size.width - 50, 50)];
    slider.tintColor = [UIColor redColor];
    slider.minimumValue = 0.0;
    slider.value = 0.5;
    _percent = 0.5;
    slider.maximumValue = 1.0;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    NSString *name = @"重量 重庆 饕餮";
    NSString *pinyin = [self phonetic:name];
    NSLog(@"%@ %@",name,pinyin);
}

- (NSString *) phonetic:(NSString*)sourceString {
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source;
}

-(void)sliderValueChanged:(UISlider *)slide{
    self.percent = slide.value;
    drawingView.percent = slide.value;
}

-(void)drawingView:(DrawingView *)drawingView PercentChangeTo:(CGFloat)percent{
    self.percent = percent;
}

-(void)setPercent:(CGFloat)percent{
    _percent = percent;
    slider.value = percent;
    label.text = [NSString stringWithFormat:@"%.1f",percent];
}
@end
