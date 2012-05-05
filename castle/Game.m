//
//  Game.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#define NEITHER(A, B) = 

#import "Game.h"
#import "CharacterPickerViewController.h"
#import "NSArray+Additions.h"

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
        _navController = [UINavigationController new];
        _turnVC = [[TurnViewController alloc] init];
        _tradeVC = [[AcceptTradeViewController alloc] init];
        _professionVC = [[ProfessionPickerViewController alloc] init];
    }
    return self;
}

- (void)start {
    PlayerCountViewController *playerCountVC = [PlayerCountViewController new];
    [_tradeVC registerObservers];
    [_turnVC registerObservers];
    [_navController addChildViewController:playerCountVC];
}

- (void)pickCharacters {
    CharacterPickerViewController *characterPickerVC = [CharacterPickerViewController new];
    [_navController pushViewController:characterPickerVC animated:YES];
}

- (void)setCurrentPlayer:(Player *)currentPlayer {
    _currentPlayer = currentPlayer;
}

- (void)nextTurn {
    assert(_playerCount);
    
    _turn += 1;
    if (_turn == _playerCount){
        _turn = 0;
        _round += 1;
    }
    
    [self setCurrentPlayer:[_players objectAtIndex:_turn]];
}

- (void)setPlayerCount:(NSUInteger)count {
    if (!_playerCount){
        NSMutableArray *players = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; i++) {
            Player *player = [[Player alloc] initWithName:[NSString stringWithFormat:@"Player %i", i]];
            [players insertObject:player atIndex:i];
        }
        _players = players;
        [self setCurrentPlayer:[players objectAtIndex:0]];
        _playerCount = count;
    } else {
        NSLog(@"Player count alreay set.");
    }
}

- (TurnViewController *)turnVC {
    return _turnVC;
}

- (NSArray *)players {
    return [NSArray arrayWithArray:_players];
}

- (NSArray *)playersOmitting:(Player *)player {
    NSMutableArray *omittingArray = [NSMutableArray arrayWithArray:_players];
    [omittingArray removeObject:player];
    return [NSArray arrayWithArray:omittingArray];
}
- (NSArray *)playersOmittingCurrent {
    return [self playersOmitting:self.currentPlayer];
}
/* Omitting Current */
- (Player *)playerAtIndexPath:(NSIndexPath *)indexPath {
    return [[self playersOmittingCurrent] objectAtIndex:indexPath.row];
}

- (void)newTurn {
    [_navController pushViewController:_turnVC animated:YES];
}

- (void)setOfferedItem:(Item *)offeredItem {
    _offeredItem = offeredItem;
}

- (void)setGivingPlayer:(Player *)player {
    _givingPlayer = player;
}

- (void)setReceivingPlayer:(Player *)player {
    _receivingPlayer = player;
}

- (void)cleanupTrade {
    [self setGivingPlayer:nil];
    [self setReceivingPlayer:nil];
    self.offeredItem = nil;
    [_navController popViewControllerAnimated:YES];
}
- (void)offerTradeTo:(Player *)toPlayer {
    [self setGivingPlayer:self.currentPlayer];
    [self setReceivingPlayer:toPlayer];
    [_navController pushViewController:_tradeVC animated:YES];
}
- (void)acceptTradeWithItem:(Item *)receivedItem {
    [self.givingPlayer removeItemFromHand:self.offeredItem];
    [self.givingPlayer addItemToHand:receivedItem];
    [self.receivingPlayer removeItemFromHand:receivedItem];
    [self.receivingPlayer addItemToHand:self.offeredItem];
    // Trigger A BAG HAS BEEN TRADED message

    if (!![@[receivedItem, self.offeredItem] any:[Item checkerFor:kShatteredMirror]]){
        if (!_itemDeck.isEmpty){
            if (receivedItem.isBag){
                [self.receivingPlayer addItemToHand:[_itemDeck drawCard]];
            } else if (self.offeredItem.isBag){
                [self.givingPlayer addItemToHand:[_itemDeck drawCard]];
            }
        }

        if (receivedItem.id == kCoat){
            [_professionVC pickProfessionForPlayer:self.givingPlayer];
        } else if (self.offeredItem.id == kCoat){
            [_professionVC pickProfessionForPlayer:self.receivingPlayer];
        }
    }

    [self cleanupTrade];
}
- (void)declineTrade {
    self.givingPlayer.pityTokens += 1;
    [self cleanupTrade];
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
        [player addItemToHand:[_itemDeck drawCard]];
        [player addItemToHand:[_itemDeck drawCard]];

        NSNumber *affiliation = [affiliationArray objectAtIndex:i];
        [player setAffiliation:[affiliation unsignedIntValue]];
        
        player.profession = [_professionDeck drawCard];
        
        NSLog(@"%@, %@, %@", player.teamName, player.profession, player.items);
        i++;
    }
    
    [self newTurn];
}

@end
