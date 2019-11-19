//
//  UIView+Extension.m
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
//
//-(void)setSize:(CGSize)size{
//    self.bounds = CGRectMake(0, 0, size.width, size.height);
//}
//
//-(CGSize)size{
//    return self.bounds.size;
//}
//
//-(void)setW:(CGFloat)w{
//    
//    CGRect frm = self.frame;
//    frm.size.width = w;
//    self.frame = frm;
//}
//
//-(CGFloat)w{
//    return self.size.width;
//}
//
//
//-(void)setH:(CGFloat)h{
//    CGRect frm = self.frame;
//    frm.size.height = h;
//    self.frame = frm;
//}
//
//-(CGFloat)h{
//    return self.size.height;
//}
//
//-(void)setX:(CGFloat)x{
//    CGRect frm = self.frame;
//    frm.origin.x = x;
//    
//    self.frame = frm;
//}
//-(CGFloat)x{
//    return self.frame.origin.x;
//}
//
//-(void)setY:(CGFloat)y{
//    CGRect frm = self.frame;
//    frm.origin.y = y;
//    
//    self.frame = frm;
//    
//}
//
//-(CGFloat)y{
//    return self.frame.origin.y;
//}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    
}

- (CGPoint)origin
{
    return self.frame.origin;
}


- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    
    return self.center.x;
}


- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
@end
