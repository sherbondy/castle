//
//  Game.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize turn = _turn;
@synthesize round = _round;

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

- (void)setPlayers:(NSArray *)players {
    _players = players;
    _playerCount = [players count];
}

@end
