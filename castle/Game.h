//
//  Game.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Player.h"
#import "ItemDeck.h"
#import "ProfessionDeck.h"
#import "PlayerCountViewController.h"
#import "TurnViewController.h"
#import "AcceptTradeViewController.h"

@interface Game : NSObject {
    @private
    NSUInteger      _playerCount;
    NSUInteger      _turn;
    NSUInteger      _round;
    Player         *_currentPlayer;
    Player         *_givingPlayer;
    Player         *_receivingPlayer;
    NSDictionary   *_offeredItem;
    NSMutableArray *_players;
    ItemDeck       *_itemDeck;
    ProfessionDeck *_professionDeck;
    UINavigationController *_navController;
    TurnViewController *_turnVC;
    AcceptTradeViewController *_tradeVC;
}

@property (nonatomic, assign)   NSUInteger playerCount;
@property (nonatomic, readonly) NSUInteger turn;
@property (nonatomic, readonly) NSUInteger round;
@property (nonatomic, readonly) Player    *currentPlayer;
@property (nonatomic, readonly) Player    *givingPlayer;
@property (nonatomic, readonly) Player    *receivingPlayer;
@property (nonatomic, readonly) NSDictionary *offeredItem;
@property (nonatomic, readonly) UIViewController *navController;
@property (nonatomic, readonly) NSArray *players;

+ (Game *)sharedGame;
- (void)start;
- (void)pickCharacters;
- (void)nextTurn;
- (void)setPlayerCount:(NSUInteger)count;
- (void)distributeCards;
- (NSArray *)players;
- (NSArray *)playersOmitting:(Player *)player;
- (NSArray *)playersOmittingCurrent;
- (Player *)playerAtIndexPath:(NSIndexPath *)indexPath;
- (TurnViewController *)turnVC;
- (void)setOfferedItem:(NSDictionary *)offeredItem;
- (void)setGivingPlayer:(Player *)givingPlayer;
- (void)setReceivingPlayer:(Player *)receivingPlayer;

- (void)offerTradeFrom:(Player *)fromPlayer to:(Player *)toPlayer;

@end