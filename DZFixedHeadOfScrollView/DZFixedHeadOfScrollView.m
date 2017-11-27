//
//  DZFixedHeadOfScrollView.m
//  HouseInfo
//
//  Created by 陈东芝 on 17/4/1.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "DZFixedHeadOfScrollView.h"
#import "UIView+Frame.h"
#import <DZRollingTabView/DZRollingTabView.h>
#import "Masonry.h"

#define TotalHaderViewHeight (self.headerView.height+RollingTabViewHeight)

static CGFloat RollingTabViewHeight = 48.0;

@interface DZFixedHeadOfScrollView ()
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *scrollViews;
@property (nonatomic, retain) DZRollingTabView *rollingTabView;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UIScrollView *presentScrollView;
@end

@implementation DZFixedHeadOfScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initData {
    _moveShowBottomHeight = 50.0;
    self.y = - self.height;
    self.NavBarShow = NO;
    _pullDownMoveHeaderView = YES;
}

- (void)initView {
    self.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

////判断UIScrollView滑动偏移是否是head固定
- (BOOL)isFixedView:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGFloat showBottomHeight = TotalHaderViewHeight-_moveShowBottomHeight-navHeight;
    CGFloat offsetY = startContentInsetTop+offset.y;
    if (offsetY >= showBottomHeight) {///上滑到显示边界，滑动固定视图
        return YES;
    }else {///bar没有固定，偏移量和上一个一样
        return NO;
    }
}

- (void)setHeaderViewFrameWithOffset:(CGPoint)offset {
    CGFloat showBottomHeight = TotalHaderViewHeight-_moveShowBottomHeight-navHeight;
    ///直接转直观的偏移量   :  >0 上拉   <0  下拉
    CGFloat offsetY = startContentInsetTop+offset.y;
    ////将偏移量转换相对header的高度
    if (offsetY >= showBottomHeight) {///上滑到显示边界，固定视图
        self.headerView.y = offset.y - showBottomHeight;
    }else {
        if (!self.pullDownMoveHeaderView) {
            if (offsetY < 0) {
                self.headerView.y = offset.y;
            }
            return;
        }
        if (self.headerView.y != -self.headerView.height ) {///可能惯性滑动使得self 不能设置frame
            self.headerView.y = -self.headerView.height;
        }
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[@"new"] CGPointValue];
        [self setHeaderViewFrameWithOffset:offset];
    }
}

#pragma mark - setter
- (void)setSV_Content:(UIScrollView *)SV_Content {
    if (_SV_Content) {
        [_SV_Content removeObserver:self forKeyPath:@"contentOffset"];
        
        /******切换下一个UIScrollView*******/
        CGPoint offset = _SV_Content.contentOffset;
        CGFloat showBottomHeight = self.height-_moveShowBottomHeight;
        /*----判断上一个contentView是否滑动到固定了head*/
        BOOL fixedLast = [self isFixedView:_SV_Content];
        /*----判断下一个contentView是否滑动到固定了head*/
        BOOL fixedNext = [self isFixedView:SV_Content];
        
        if (fixedLast) {
            self.y = offset.y - showBottomHeight;
            if (fixedNext) {
                [self setHeaderViewFrameWithOffset:SV_Content.contentOffset];
            }else {///下一个SV没有是head固定，就让他固定
                CGPoint offsetNextSV = CGPointMake(0, -_moveShowBottomHeight-navHeight);
                SV_Content.contentOffset = offsetNextSV;
                [self setHeaderViewFrameWithOffset:offsetNextSV];
            }
        }else {
            SV_Content.contentOffset = _SV_Content.contentOffset;
            [self setHeaderViewFrameWithOffset:offset];
        }
    }

    _SV_Content = SV_Content;
     [_SV_Content addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    startContentInsetTop = self.height;
}

- (void)setNavBarShow:(BOOL)NavBarShow {
    _NavBarShow = NavBarShow;
    if (NavBarShow) {
        navHeight = 0.0;
    }else {
        navHeight = 64.0;
    }
}

- (DZRollingTabView *)rollingTabView {
    if (_rollingTabView == nil) {
        _rollingTabView = [[DZRollingTabView alloc] init];
        _rollingTabView.backgroundColor = [UIColor whiteColor];
    }
    return _rollingTabView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.y = - self.height;
}

- (void)setItems:(NSArray<DZFixedHeadOfScrollViewItem *> *)items {
    _items = items;
    NSMutableArray *titles = [NSMutableArray new];
    NSMutableArray *scrollViews = [NSMutableArray new];
    
    UIView *contentView = [UIView new];
    [self.mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.height.equalTo(self.mainScrollView);
    }];
    
    UIView *lastView;
    for (int i = 0; i < items.count; i++) {
        DZFixedHeadOfScrollViewItem *item = items[i];
        [titles addObject:item.title];
        
        UIScrollView *scrollView = item.scrollView;
        [scrollViews addObject:scrollView];
    
        [contentView addSubview:scrollView];
        scrollView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(_headerView.bounds)+RollingTabViewHeight, 0, 0, 0);
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((lastView ? lastView.mas_right : @0));
            make.top.bottom.equalTo(@0);
            make.width.equalTo(self.mainScrollView);
        }];
        lastView = item.scrollView;
    }
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
    
    self.rollingTabView.arrayTitles = titles;
    [self addSubview:self.rollingTabView];
    [self.rollingTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.equalTo(@(RollingTabViewHeight));
    }];
    
    self.scrollViews = scrollViews;
    self.titles = titles;
    
    self.selectedIndex = 0;
}

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
    }
    return _mainScrollView;
}

- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;
    
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(CGRectGetHeight(_headerView.bounds)));
    }];
    
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex >= self.scrollViews.count) return;
    
    _selectedIndex = selectedIndex;
    UIScrollView *presentScrollView = self.scrollViews[selectedIndex];
    self.presentScrollView = presentScrollView;
}

- (void)setPresentScrollView:(UIScrollView *)presentScrollView {

    if (_presentScrollView) {
        [_presentScrollView removeObserver:self forKeyPath:@"contentOffset"];
        
        /******切换下一个UIScrollView*******/
        CGPoint offset = _presentScrollView.contentOffset;
        CGFloat showBottomHeight = TotalHaderViewHeight-_moveShowBottomHeight;
        /*----判断上一个contentView是否滑动到固定了head*/
        BOOL fixedLast = [self isFixedView:_presentScrollView];
        /*----判断下一个contentView是否滑动到固定了head*/
        BOOL fixedNext = [self isFixedView:presentScrollView];
        
        if (fixedLast) {
            self.y = offset.y - showBottomHeight;
            if (fixedNext) {
                [self setHeaderViewFrameWithOffset:presentScrollView.contentOffset];
            }else {///下一个SV没有是head固定，就让他固定
                CGPoint offsetNextSV = CGPointMake(0, -_moveShowBottomHeight-navHeight);
                presentScrollView.contentOffset = offsetNextSV;
                [self setHeaderViewFrameWithOffset:offsetNextSV];
            }
        }else {
            presentScrollView.contentOffset = _presentScrollView.contentOffset;
            [self setHeaderViewFrameWithOffset:offset];
        }
    }
    
    _presentScrollView = presentScrollView;
    [_presentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    startContentInsetTop = self.height;
}

#pragma mark -
- (void)dealloc {
    [_SV_Content removeObserver:self forKeyPath:@"contentOffset"];
}

@end
