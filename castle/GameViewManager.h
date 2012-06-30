//
//  CastleViewManager.h
//  castle
//
//  Created by Ethan Sherbondy on 6/27/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@class TurnViewController;
@class AcceptTradeViewController;
@class ProfessionPickerViewController;

@interface GameViewManager : NSObject <GameDelegate> {
    UINavigationController *_navController;
    TurnViewController *_turnVC;
    AcceptTradeViewController *_tradeVC;
    ProfessionPickerViewController *_professionVC;
}

@property (nonatomic, readonly) UIViewController    *navController;
@property (nonatomic, readonly) TurnViewController  *turnVC;

@end
