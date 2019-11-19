//
//  GKScrollView.m
//  GKZTC
//
//  Created by 黄文鸿 on 2019/5/22.
//  Copyright © 2019 乐无边. All rights reserved.
//

#import "GKScrollView.h"
#import "UIScrollView+GKNest.h"
#import "UIView+Extension.h"

@interface GKScrollView()

@property (nonatomic, assign) BOOL pullDown;//YES：下拉 NO：上拉
@property (nonatomic, assign) CGFloat offsetYWhenPulldownBegin;
@end

@implementation GKScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    return self;
}


- (void)setContentOffset:(CGPoint)contentOffset {
    BOOL oldPulldown = self.pullDown;
    self.pullDown = contentOffset.y < self.contentOffset.y;
    if(self.pullDown && !oldPulldown) {
        self.offsetYWhenPulldownBegin = self.contentOffset.y;
    }
    
    [super setContentOffset:contentOffset];
    
    if(self.currentSubScrollView) {
            if(self.pullDown) {//如果是下拉
                
                //子sub scroll 仍然可以向下滚，本scroll view不动
                if(self.currentSubScrollView.contentOffset.y > -self.currentSubScrollView.contentInset.top) {
                    CGFloat fixedOffset = self.contentSize.height - self.height;
                    fixedOffset = MIN(fixedOffset, self.offsetYWhenPulldownBegin);
                    [super setContentOffset:CGPointMake(0, fixedOffset)];
                }
            }
        }
}

- (void)setCurrentSubScrollView:(UIScrollView *)currentSubScrollView {
    if(_currentSubScrollView) {
        _currentSubScrollView.superScrollView = nil;
    }
    _currentSubScrollView = currentSubScrollView;
    _currentSubScrollView.superScrollView = self;
    self.pullDown = NO;
}
#pragma mark - 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    UIView *otherView = otherGestureRecognizer.view;
    if(otherView == self.currentSubScrollView) {
        return YES;
    }
    return NO;
}
@end
