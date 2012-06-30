//
//  Game.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Player.h"
#import "ItemDeck.h"
#import "ProfessionDeck.h"
#import "Item.h"

@protocol GameDelegate;

@interface Game : NSObject {
    @private
    NSUInteger      _playerCount;
    NSUInteger      _turn;
    NSUInteger      _round;
    Player         *_currentPlayer;
    Player         *_givingPlayer;
    Player         *_receivingPlayer;
    Item           *_offeredItem;
    NSMutableArray *_players;
    ItemDeck       *_itemDeck;
    ProfessionDeck *_professionDeck;
}

@property (nonatomic, assign)   NSUInteger           playerCount;
@property (nonatomic, weak)     id <GameDelegate>    delegate;
@property (nonatomic, readonly) NSUInteger           turn;
@property (nonatomic, readonly) NSUInteger           round;
@property (nonatomic, readonly) Player              *currentPlayer;
@property (nonatomic, readonly) Player              *givingPlayer;
@property (nonatomic, readonly) Player              *receivingPlayer;
@property (nonatomic, readonly) Item                *offeredItem;
@property (nonatomic, readonly) NSArray             *players;

+ (Game *)sharedGame;
- (void)start;
- (void)pickCharacters;
- (void)nextTurn;
- (void)setPlayerCount:(NSUInteger)count;
- (void)setCurrentPlayer:(Player *)currentPlayer;
- (void)distributeCards;
- (NSArray *)players;
- (NSArray *)playersOmitting:(Player *)player;
- (NSArray *)playersOmittingCurrent;
- (Player *)playerAtIndexPath:(NSIndexPath *)indexPath;
- (void)setOfferedItem:(Item *)offeredItem;
- (void)setGivingPlayer:(Player *)givingPlayer;
- (void)setReceivingPlayer:(Player *)receivingPlayer;

- (void)offerTradeTo:(Player *)toPlayer;
- (void)acceptTradeWithItem:(Item *)receivedItem;
- (void)declineTrade;

@end

@protocol GameDelegate

- (void)startNewGame;
- (void)showCharacterPicker;
- (void)startNextTurn;
- (void)didCleanupTrade;
- (void)handleTradeOffer;
- (void)handleCoatReceivedByPlayer:(Player *)recipient;
- (void)setReceivingPlayer:(Player *)recipient;

@end
