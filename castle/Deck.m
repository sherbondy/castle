//
//  Deck.m
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Deck.h"

@implementation Deck

- (id)init {
    if (!self) {
        self = [self initWithCards:nil];
    }
    return self;
}
                
- (id)initWithCards:(NSArray *)cards {
    if ((self = [super init])){
        _cards = [NSMutableArray arrayWithArray:cards];
    }
    return self;
}

- (void)shuffle {
    [_cards shuffle];
}

- (id)drawCard {
    id card = [[_cards objectAtIndex:1] copy];
    [_cards removeObjectAtIndex:1];
    return card;
}

- (void)placeCardAtTop:(id)card {
    [_cards insertObject:card atIndex:0];
}

- (void)placeCardAtBottom:(id)card {
    [_cards addObject:card];
}

- (NSArray *)cards {
    return [NSArray arrayWithArray:_cards];
}

@end
