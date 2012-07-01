//
//  CastleViewManager.m
//  castle
//
//  Created by Ethan Sherbondy on 6/27/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "GameViewManager.h"
#import "TurnViewController.h"
#import "AcceptTradeViewController.h"
#import "ProfessionPickerViewController.h"
#import "PlayerCountViewController.h"
#import "CharacterPickerViewController.h"

@implementation GameViewManager

- (id)init {
    if (self = [super init]){
        _navController = [UINavigationController new];
        _turnVC = [[TurnViewController alloc] init];
        _tradeVC = [[AcceptTradeViewController alloc] init];
        _professionVC = [[ProfessionPickerViewController alloc] init];
    }
    return self;
}

- (void)startNewGame {
    [_turnVC registerObservers];
    
    PlayerCountViewController *playerCountVC = [PlayerCountViewController new];
    [_navController addChildViewController:playerCountVC];
}

- (void)showCharacterPicker {
    CharacterPickerViewController *characterPickerVC = [CharacterPickerViewController new];
    [_navController pushViewController:characterPickerVC animated:YES];
}

- (void)startNextTurn {
    [_navController pushViewController:_turnVC animated:YES];
}

- (void)didCleanupTrade {
    [_navController popViewControllerAnimated:YES];
}

- (void)handleTradeOffer {
    [_tradeVC updateOffer];
    [_navController pushViewController:_tradeVC animated:YES];
}

- (void)handleCoatReceivedByPlayer:(Player *)recipient{
    [_professionVC pickProfessionForPlayer:recipient];
}

- (void)setReceivingPlayer:(Player *)recipient {
    [_turnVC setReceivingPlayer:recipient];
}

@end
