//
//  UIButton+Additions.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

- (void)setDefaultTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

@end
