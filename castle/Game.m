//
//  Game.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Game.h"
#import "CharacterPickerViewController.h"

@implementation Game

@synthesize navController = _navController;

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
        _navController = [UINavigationController new];
        _turnVC = [TurnViewController new];
    }
    return self;
}

- (void)start {
    PlayerCountViewController *playerCountVC = [PlayerCountViewController new];
    [_navController addChildViewController:playerCountVC];
}

- (void)pickCharacters {
    CharacterPickerViewController *characterPickerVC = [CharacterPickerViewController new];
    [_navController pushViewController:characterPickerVC animated:YES];
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

- (void)newTurn {
    [_navController pushViewController:_turnVC animated:YES];
}

- (void)distributeCards {
    [_players shuffle];
    // count of goblets/bags/etc actually varies based on number of players
    _itemDeck = [ItemDeck new];
    _professionDeck = [ProfessionDeck new];

    NSMutableArray *startingObjects = [_itemDeck drawStartingObjectsForPlayerCount:_playerCount];
    
    int affiliationAmount = ceil(_playerCount/2.0);
    NSMutableArray *affiliationArray = [NSMutableArray arrayWithCapacity:affiliationAmount*2];
    for (int i = 0; i < affiliationAmount; i++) {
        [affiliationArray addObject:@0];
        [affiliationArray addObject:@1];
    }
    [affiliationArray shuffle];
        
    int i = 0;
    for (Player *player in _players){
        [player addItemToHand:[startingObjects objectAtIndex:i]];
        
        NSNumber *affiliation = [affiliationArray objectAtIndex:i];
        [player setAffiliation:[affiliation unsignedIntValue]];
        
        player.profession = [_professionDeck drawCard];
        
        NSLog(@"%@, %@, %@", player.teamName, player.profession, player.items);
        i++;
    }
    
    [self newTurn];
}

@end
