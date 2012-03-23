//
//  Game.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Game.h"

@implementation Game

+ (Game *)sharedGame {
    static dispatch_once_t pred;
    static Game *game = nil;
    
    dispatch_once(&pred, ^{ game = [[self alloc] init]; });
    return game;
}

- (id)init {
    if ((self = [super init])){
        _turn = 0;
        _round = 0;
    }
    return self;
}

- (void)nextTurn {
    assert(_playerCount);
    
    _turn += 1;
    if (_turn == _playerCount){
        _turn = 0;
        _round += 1;
    }
    
    _currentPlayer = [_players objectAtIndex:_turn];
}

- (void)setPlayerCount:(NSUInteger)count {
    if (!_playerCount){
        NSMutableArray *players = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; i++) {
            Player *player = [[Player alloc] initWithName:[NSString stringWithFormat:@"Player %i", i]];
            [players insertObject:player atIndex:i];
        }
        _players = players;
        _currentPlayer = [players objectAtIndex:0];
        _playerCount = count;
    } else {
        NSLog(@"Player count alreay set.");
    }
}

- (void)distributeCards {
    [_players shuffle];
    // count of goblets/bags/etc actually varies based on number of players
    _itemDeck = [[ItemDeck alloc] init];
    NSMutableArray *startingObjects = [_itemDeck drawStartingObjectsForPlayerCount:_playerCount];
    
    int i = 0;
    for (Player *player in _players){
        [player addItemToHand:[startingObjects objectAtIndex:i]];
        NSLog(@"%i", _itemDeck.count);
        i++;
    }
}

@end
