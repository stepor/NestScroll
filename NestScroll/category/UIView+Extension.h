//
//  UIView+Extension.h
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//
///**
// *  UIView的尺寸
// */
//@property(nonatomic,assign)CGSize size;
//
///**
// *  获取或者更改控件的宽度
// */
//@property(nonatomic,assign)CGFloat w;
//
///**
// *  获取或者更改控件的高度
// */
//@property(nonatomic,assign)CGFloat h;
//
///**
// *  获取或者更改控件的x坐标
// */
//@property(nonatomic,assign)CGFloat x;
//
///**
// *  获取或者更改控件的y坐标
// */
//@property(nonatomic,assign)CGFloat y;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property(nonatomic, assign) CGFloat centerX;

@property(nonatomic, assign) CGFloat centerY;

@property(nonatomic, assign, readonly) CGFloat maxX;
@property(nonatomic, assign, readonly) CGFloat maxY;
@end
