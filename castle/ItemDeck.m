//
//  ItemDeck.m
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "ItemDeck.h"

@implementation ItemDeck

- (id)init {
    NSArray *cards = @[ @"Testing", @"Whee", @"One", @"Two", @"Three" ];
    self = [super initWithCards:cards];
    return self;
}

@end
