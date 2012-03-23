//
//  ItemDeck.h
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Deck.h"

@interface ItemDeck : Deck

- (id)init;
- (NSMutableArray *)drawStartingObjectsForPlayerCount:(NSUInteger)playerCount;

@end
