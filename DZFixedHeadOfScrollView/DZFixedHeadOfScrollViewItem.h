//
//  DZFixedHeadOfScrollViewItem.h
//  DZFixedHeadOfScrollViewDome
//
//  Created by iMac on 2017/11/27.
//  Copyright © 2017年 ChenDongZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DZFixedHeadOfScrollViewItem : NSObject

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) NSString *title;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView andTitle:(NSString *)title;

@end
