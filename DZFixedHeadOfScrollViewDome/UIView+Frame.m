//
//  UIView+Frame.m
//  FangBangBangJingJi
//
//  Created by iMac on 2017/4/13.
//  Copyright © 2017年 ChenDongZhi. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    CGRect frame = self.frame;
    return frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)height{
    CGRect frame = self.frame;
    return frame.size.height;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    CGRect frame = self.frame;
    return frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    CGRect frame = self.frame;
    return frame.origin.y;
}

- (CGFloat)getMaxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)getMaxY {
    return CGRectGetMaxY(self.frame);
}

- (CGPoint)getCenterPoint {
    return CGPointMake(self.width/2.0, self.height/2.0);
}

- (CGFloat)centerX {
    CGPoint point = self.center;
    return point.x;
}

- (CGFloat)centerY {
    CGPoint point = self.center;
    return point.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

@end
