//
//  UIView+Utilities.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
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

@end
