
//
//  DrawingView.m
//  ben500
//
//  Created by wangchen on 15/8/27.
//  Copyright (c) 2015年 com.ben500. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView(){
    CGFloat lastY;
}

@end

@implementation DrawingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lineWidth = 5;
        self.percent = 0.5;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

-(void)pan:(UIGestureRecognizer *)recognizer{
    CGFloat Y = [recognizer locationInView:recognizer.view].y;
    if (recognizer.state == 1) {
        lastY = Y;
    }else if (recognizer.state == 2){
        self.percent += (Y - lastY) * 0.01;
        NSLog(@"%f",self.percent);
        lastY = Y;
    }
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //设置当前模式为正常
    CGContextSetBlendMode(con, kCGBlendModeNormal);
    
    CGFloat width = rect.size.width > rect.size.height ? rect.size.height : rect.size.width;
    
    width = width - _lineWidth;
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    CGContextAddEllipseInRect(con, CGRectMake(center.x - width / 2, center.y - width / 2, width, width));
    if (_percent == 0.5) {
        CGContextSetRGBStrokeColor(con,0,0,1,1);
    }else if (_percent < 0.5){
        CGContextSetRGBStrokeColor(con,1 - _percent * 2,0,_percent * 2,1);
    }else{
        CGContextSetRGBStrokeColor(con,0,(_percent - 0.5) * 2 ,1 - (_percent - 0.5) * 2,1);
    }
    CGContextSetLineWidth(con, _lineWidth);
    CGContextStrokePath(con);
    
    /*
     //画一个圆
     CGContextAddEllipseInRect(con, CGRectMake(center.x - width / 2, center.y - width / 2, width, width));
     if (_percent == 0.5) {
     CGContextSetFillColorWithColor(con, [UIColor colorWithRed:0 green:0 blue:1 alpha:1.0].CGColor);
     }else if (_percent < 0.5){
     CGContextSetFillColorWithColor(con, [UIColor colorWithRed:1 - _percent * 2 green:0 blue:_percent * 2 alpha:1.0].CGColor);
     }else{
     CGContextSetFillColorWithColor(con, [UIColor colorWithRed:0 green:(_percent - 0.5) * 2 blue:1 - (_percent - 0.5) * 2 alpha:1.0].CGColor);
     }
     CGContextFillPath(con);
     
     //清除模式（橡皮擦）
     CGContextSetBlendMode(con, kCGBlendModeClear);
     //画一个小圆，即清除大圆内部的小圆范围
     CGContextAddEllipseInRect(con, CGRectMake(_lineWidth, _lineWidth, width - 2 * _lineWidth, width - 2 * _lineWidth));
     CGContextFillPath(con);
     
     //恢复正常模式
     CGContextSetBlendMode(con, kCGBlendModeNormal);
     */
    
    CGPoint firstPoint = CGPointMake(center.x - width / 4, center.y + width / 4);
    CGPoint secondPoint = CGPointMake(center.x + width / 4, center.y + width / 4);
    
    //画弧线
    CGContextSetLineCap(con, kCGLineCapRound);
    CGContextMoveToPoint(con, firstPoint.x, firstPoint.y);//圆弧的起始点
    
    if (self.percent > 0.51 || self.percent < 0.49) {        CGPoint moveToPoint = CGPointMake(center.x, center.y + width / 2 * _percent);
        CGContextAddArcToPoint(con, moveToPoint.x , moveToPoint.y, secondPoint.x, secondPoint.y, [self getRadiusFromPoint:secondPoint MovingPoint:moveToPoint]);
    }else{
        CGContextAddLineToPoint(con, secondPoint.x, secondPoint.y);
    }
    
    CGContextStrokePath(con);
}

//勾股定理求半径。。。
-(CGFloat)getRadiusFromPoint:(CGPoint)point MovingPoint:(CGPoint)movingPoint{
    
    CGFloat shortLine = sqrt((point.x - movingPoint.x) * (point.x - movingPoint.x) + (point.y - movingPoint.y) * (point.y - movingPoint.y));
    
    CGFloat littleShortLine = fabs(point.y - movingPoint.y);
    CGFloat littleLongLine = fabs(point.x - movingPoint.x);
    CGFloat littleLongLongLine = shortLine;
    
    CGFloat longLine = shortLine * littleLongLine / littleShortLine;
    CGFloat longlongline = littleLongLongLine * shortLine / littleShortLine;
    
    return longLine;
}

-(void)setPercent:(CGFloat)percent{
    if (percent < 0) {
        percent = 0;
    }else if (percent > 1){
        percent = 1;
    }
    _percent = percent;
    
    if ([self.delegate respondsToSelector:@selector(drawingView:PercentChangeTo:)]) {
        [self.delegate drawingView:self PercentChangeTo:percent];
    }
    
    [self setNeedsDisplay];
}

@end
