//
//  UIView+Utilities.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

enum {
    UIViewAutoresizingHorizontal = (UIViewAutoresizingFlexibleLeftMargin | 
                                    UIViewAutoresizingFlexibleWidth | 
                                    UIViewAutoresizingFlexibleRightMargin),
    UIViewAutoresizingVertical = (UIViewAutoresizingFlexibleTopMargin | 
                                  UIViewAutoresizingFlexibleHeight | 
                                  UIViewAutoresizingFlexibleBottomMargin),
    UIViewAutoresizingFlexibleMargins = (UIViewAutoresizingFlexibleTopMargin |
                                         UIViewAutoresizingFlexibleLeftMargin |
                                         UIViewAutoresizingFlexibleRightMargin |
                                         UIViewAutoresizingFlexibleBottomMargin),
    UIViewAutoResizingFlexibleDimensions = (UIViewAutoresizingFlexibleWidth |
                                            UIViewAutoresizingFlexibleHeight),
    UIViewAutoresizingAll = (UIViewAutoresizingFlexibleLeftMargin | 
                             UIViewAutoresizingFlexibleWidth | 
                             UIViewAutoresizingFlexibleRightMargin | 
                             UIViewAutoresizingFlexibleTopMargin | 
                             UIViewAutoresizingFlexibleHeight | 
                             UIViewAutoresizingFlexibleBottomMargin)
};
typedef NSUInteger UIViewAutoresizing;

@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;

- (void)addSubviews:(UIView *)firstSubview, ...;

@end
