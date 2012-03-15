//
//  Game.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Player.h"

@interface Game : NSObject {
    @private
    NSUInteger _playerCount;
    NSUInteger _turn;
    NSUInteger _round;
    Player    *_currentPlayer;
    NSArray   *_players;
}

@property (nonatomic, assign)   NSUInteger playerCount;
@property (nonatomic, readonly) NSUInteger turn;
@property (nonatomic, readonly) NSUInteger round;
@property (nonatomic, readonly) Player    *currentPlayer;

+ (Game *)sharedGame;
- (void)nextTurn;
- (void)setPlayerCount:(NSUInteger)count;

@end