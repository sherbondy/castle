//
//  NSMutableArray+Shuffle.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <Foundation/Foundation.h>

// A simple Fisher-Yates shuffle implementation. 

@interface NSMutableArray (Shuffle)

- (void)shuffle;

@end
