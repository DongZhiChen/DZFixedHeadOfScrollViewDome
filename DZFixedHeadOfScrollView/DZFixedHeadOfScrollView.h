//
//  DZFixedHeadOfScrollView.h
//  HouseInfo
//
//  Created by 陈东芝 on 17/4/1.
//  Copyright © 2017年 陈东芝. All rights reserved.
//


#import "DZFixedHeadOfScrollViewItem.h"
#import <UIKit/UIKit.h>

@interface DZFixedHeadOfScrollView : UIView {
    CGFloat startContentInsetTop;
    CGFloat navHeight;
}

/**
 底部显示的高度 默认 50.0
 */
@property (nonatomic, assign) CGFloat moveShowBottomHeight;

/**
 用于监听滚动位置，设置header
 */
@property (nonatomic, retain) UIScrollView *SV_Content;

/**
 导航栏是否显示 默认 No
 */
@property (nonatomic, assign) BOOL NavBarShow;

/**
 下拉header是否跟着一起移动 默认 Yes
 */
@property (nonatomic, assign) BOOL pullDownMoveHeaderView;



@property (nonatomic, retain) UIView *headerView;

@property (nonatomic, retain) NSArray<DZFixedHeadOfScrollViewItem *> *items;

@property (nonatomic, assign) NSInteger selectedIndex;


@end
