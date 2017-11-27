//
//  DZFixedHeadOfScrollViewItem.m
//  DZFixedHeadOfScrollViewDome
//
//  Created by iMac on 2017/11/27.
//  Copyright © 2017年 ChenDongZhi. All rights reserved.
//

#import "DZFixedHeadOfScrollViewItem.h"

@implementation DZFixedHeadOfScrollViewItem

- (instancetype)initWithScrollView:(UIScrollView *)scrollView andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _scrollView = scrollView;
        _title = title;
    }
    return self;
}

@end
