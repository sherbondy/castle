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

@interface Game : NSObject {
    @private
    NSUInteger      _playerCount;
    NSUInteger      _turn;
    NSUInteger      _round;
    Player         *_currentPlayer;
    NSMutableArray *_players;
    ItemDeck       *_itemDeck;
    ProfessionDeck *_professionDeck;
    UINavigationController *_navController;
    TurnViewController *_turnVC;
}

@property (nonatomic, assign)   NSUInteger playerCount;
@property (nonatomic, readonly) NSUInteger turn;
@property (nonatomic, readonly) NSUInteger round;
@property (nonatomic, readonly) Player    *currentPlayer;
@property (nonatomic, readonly) UIViewController *navController;

+ (Game *)sharedGame;
- (void)start;
- (void)pickCharacters;
- (void)nextTurn;
- (void)setPlayerCount:(NSUInteger)count;
- (void)distributeCards;

@end