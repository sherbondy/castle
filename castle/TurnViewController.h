//
//  TurnViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "PlayerPickerViewController.h"
#import "ItemCarouselViewController.h"

@interface TurnViewController : UIViewController {
    UIButton *_affiliationButton;
    UIButton *_professionButton;
    UILabel *_pityTokenLabel;
    UILabel *_playerNameLabel;
    ItemCarouselViewController *_itemCarouselVC;
    PlayerPickerViewController *_playerPicker;
    PlayerAction _turnAction;
}

- (void)registerObservers;
- (void)pressedTrade:(ItemView *)itemView;
- (void)setReceivingPlayer:(Player *)player;

@end
