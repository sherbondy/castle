//
//  NSArray+Additions.h
//  castle
//
//  Created by Ethan Sherbondy on 4/28/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Additions)

- (BOOL)any:(BOOL (^)(id item))block;

@end
