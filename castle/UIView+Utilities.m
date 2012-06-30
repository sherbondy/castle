//
//  UIView+Utilities.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

@dynamic height, width, x, y;

- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)addSubviews:(UIView *)firstSubview, ... {    
    va_list args;
    va_start(args, firstSubview);
    UIView *nextView = firstSubview;
    
    while (nextView) {
        [self addSubview:nextView];
        nextView = va_arg(args, UIView *);
    }
    
    va_end(args);
}

// untested
- (UIView *)superestView {
    UIView *nextSuperView = [self superview];
    while (nextSuperView != nil){
        nextSuperView = [nextSuperView superview];
    }
    return nextSuperView;
}

@end
