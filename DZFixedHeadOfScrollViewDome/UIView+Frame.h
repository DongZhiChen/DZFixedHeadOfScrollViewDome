//
//  UIView+Frame.h
//  FangBangBangJingJi
//
//  Created by iMac on 2017/4/13.
//  Copyright © 2017年 ChenDongZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly, getter=getMaxX) CGFloat maxX;
@property (nonatomic, assign, readonly, getter=getMaxY) CGFloat maxY;

/**
 视图的中心点
 */
@property (nonatomic, assign, readonly, getter=getCenterPoint) CGPoint centerPoint;
@end
