//
//  UIScrollView+GKNest.m
//  GKZTC
//
//  Created by 黄文鸿 on 2019/11/19.
//  Copyright © 2019 乐无边. All rights reserved.
//

#import "UIScrollView+GKNest.h"
#import "UIView+Extension.h"
#import <objc/runtime.h>

static void *SubNestKey = &SubNestKey;
static void *SuperScrollViewKey = &SuperScrollViewKey;
static void *PullingUpKey = &PullingUpKey;
static void *PullingDownKey = &PullingDownKey;
static void *OffsetYKey = &OffsetYKey;

@implementation UIScrollView (GKNest)

#pragma mark - 方法切换
+ (void)load {
    //hook setContentOffset：方法
    Method originMethod = class_getInstanceMethod([UIScrollView class], @selector(setContentOffset:));
    Method newMethod = class_getInstanceMethod([UIScrollView class], @selector(setGKContentOffset:));
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)setGKContentOffset:(CGPoint)contentOffset {
//    设置 superScroll 证明是在做嵌套滚动
    UIScrollView *superScroll = self.superScrollView;
    if(superScroll) {
        //判断是否上拉
        BOOL oldPullingUp = self.gk_pullingUp;
        self.gk_pullingUp = contentOffset.y > self.contentOffset.y;
        self.gk_pullingDown = contentOffset.y < self.contentOffset.y;
        if(self.gk_pullingUp && !oldPullingUp) {
            self.gk_offsetYWhenPullUpBegin = self.contentOffset.y;
        }
    }
    
    [self setGKContentOffset:contentOffset];
    
    //处理嵌套滚动
    if(superScroll) {
        //如果上拉 ： 加入 self.contentOffset.y >= 0 防止 本身反弹时被识别为 上拉
        if(self.gk_pullingUp && self.contentOffset.y >= 0) {
            //super scroll 仍然可以向上滚，本scroll view不动
            if(superScroll.contentOffset.y < (superScroll.contentSize.height - superScroll.height)) {
                CGFloat fixedOffset = MAX(0, self.gk_offsetYWhenPullUpBegin);
                [self setGKContentOffset:CGPointMake(0, fixedOffset)];
            }
            
        //如果是下拉
        } else if(self.gk_pullingDown) {
            //super 仍然可以下滚, 而且 本身的 offsetY 已经小于 0: 这里为了 super scroll 下拉的时候， 保证 本身 的 offsetY 不小于 0
            if(superScroll.contentOffset.y > 0 && self.contentOffset.y < 0) {
                [self setGKContentOffset:CGPointMake(0, 0)];
            }
        }
    }
}

#pragma mark - setter getter
- (void)setSuperScrollView:(UIScrollView *)superScrollView {
    self.gk_pullingUp = NO;
    
    if(superScrollView && [superScrollView isKindOfClass:[UIScrollView class]]) {
        __weak UIScrollView *weakSuper = superScrollView;
        UIScrollView *(^block)(void) = ^{
            __strong UIScrollView *strongSuper = weakSuper;
            return strongSuper;
        };
        objc_setAssociatedObject(self, SuperScrollViewKey, block, OBJC_ASSOCIATION_COPY);
    } else {
        objc_setAssociatedObject(self, SuperScrollViewKey, nil, OBJC_ASSOCIATION_COPY);
    }
}
- (UIScrollView *)superScrollView {
    UIScrollView *(^block)(void)  = objc_getAssociatedObject(self, SuperScrollViewKey);
    if(block) {
        return block();
    } else {
        return nil;
    }
}

- (void)setGk_pullingUp:(BOOL)gk_pullingUp {
    objc_setAssociatedObject(self, PullingUpKey, @(gk_pullingUp), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)gk_pullingUp {
    NSNumber *num = objc_getAssociatedObject(self, PullingUpKey);
    if(num) {
        return num.boolValue;
    }
    return NO;
}

- (void)setGk_pullingDown:(BOOL)gk_pullingDown {
    objc_setAssociatedObject(self, PullingDownKey, @(gk_pullingDown), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)gk_pullingDown {
    NSNumber *num = objc_getAssociatedObject(self, PullingDownKey);
    if(num) {
        return num.boolValue;
    }
    return NO;
}

- (void)setGk_offsetYWhenPullUpBegin:(CGFloat)gk_offsetYWhenPullUpBegin {
    objc_setAssociatedObject(self, OffsetYKey, @(gk_offsetYWhenPullUpBegin), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)gk_offsetYWhenPullUpBegin {
    NSNumber *num = objc_getAssociatedObject(self, OffsetYKey);
    if(num) {
        return num.doubleValue;
    }
    return 0.0;
}

#pragma mark - 辅助方法
//- (BOOL)canMove {
//    CGFloat offsetY = self.contentOffset.y;
//    if(offsetY > 0 && offsetY < (self.contentSize.height - self.height)) {
//        return YES;
//    }
//    return NO;
//}
//- (BOOL)onTop {
//    
//}
//- (BOOL)onBottom;

@end
