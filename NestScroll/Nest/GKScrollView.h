//
//  GKScrollView.h
//  GKZTC
//
//  Created by 黄文鸿 on 2019/5/22.
//  Copyright © 2019 乐无边. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 用于嵌套滚动的 container ， delegate 属性要保留，内部要用
 2019.10.09: 不用保留 delegate 属性，内部实现逻辑更改
 */
@interface GKScrollView : UIScrollView

@property (nonatomic, weak) UIScrollView *currentSubScrollView;

@end

NS_ASSUME_NONNULL_END
