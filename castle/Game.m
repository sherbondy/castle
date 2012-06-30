//
//  Game.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "Game.h"
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
    }
    return self;
}

- (void)start {
    [self.delegate startNewGame];
}

- (void)pickCharacters {
    [self.delegate showCharacterPicker];
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
    [self.delegate startNextTurn];
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
    [self.delegate didCleanupTrade];
}

- (void)offerTradeTo:(Player *)toPlayer {
    [self setGivingPlayer:self.currentPlayer];
    [self setReceivingPlayer:toPlayer];
    [self.delegate handleTradeOffer];
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
            [self.delegate handleCoatReceivedByPlayer:self.givingPlayer];
        } else if (self.offeredItem.id == kCoat){
            [self.delegate handleCoatReceivedByPlayer:self.receivingPlayer];
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
    NSLog(@"%@", _professionDeck.cards);
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
