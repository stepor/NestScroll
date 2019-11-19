//
//  UIScrollView+GKNest.h
//  GKZTC
//
//  Created by 黄文鸿 on 2019/11/19.
//  Copyright © 2019 乐无边. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (GKNest)

@property (nonatomic, weak) UIScrollView *superScrollView;//嵌套滚动的 container

//以下属性外部不要调用
@property (nonatomic, assign) BOOL gk_pullingUp;
@property (nonatomic, assign) BOOL gk_pullingDown;
@property (nonatomic, assign) CGFloat gk_offsetYWhenPullUpBegin;
@end

NS_ASSUME_NONNULL_END
