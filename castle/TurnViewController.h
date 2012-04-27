//
//  TurnViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "PlayerPickerViewController.h"
#import "ItemCarouselViewController.h"

@interface TurnViewController : UIViewController {
    UIButton *_affiliationButton;
    UIButton *_professionButton;
    UILabel *_pityTokenLabel;
    ItemCarouselViewController *_itemCarouselVC;
    PlayerPickerViewController *_playerPicker;
    PlayerAction _turnAction;
    UIPopoverController *_popover;
}

@property (nonatomic, readonly) UIPopoverController *popover;

- (void)registerObservers;
- (void)pressedTrade:(ItemView *)itemView;
- (void)setReceivingPlayer:(Player *)player;
- (void)presentDescriptionWithTitle:(NSString *)title andDescription:(NSString *)description fromSender:(id)sender;

@end
