//
//  NSArray+Additions.m
//  castle
//
//  Created by Ethan Sherbondy on 4/28/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

// could reimplement with indexOfObjectPassingTest
- (BOOL)any:(BOOL (^)(id item))block {
    for (id elem in self){
        if (block(elem)){
            return YES;
        }
    }
    return NO;
}

@end
