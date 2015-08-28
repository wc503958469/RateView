//
//  DrawingView.h
//  ben500
//
//  Created by wangchen on 15/8/27.
//  Copyright (c) 2015年 com.ben500. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawingView;

@protocol DrawingViewDelegate <NSObject>

-(void)drawingView:(DrawingView *)drawingView PercentChangeTo:(CGFloat)percent;

@end

@interface DrawingView : UIView

@property (nonatomic ,assign)CGFloat percent;
@property (nonatomic ,assign)CGFloat lineWidth;
@property (nonatomic ,weak)id<DrawingViewDelegate>delegate;

@end
