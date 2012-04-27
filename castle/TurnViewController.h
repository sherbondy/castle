//
//  TurnViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Player.h"
#import "PlayerPickerViewController.h"

@interface TurnViewController : UIViewController <iCarouselDataSource, iCarouselDelegate> {
    UIButton *_affiliationButton;
    UIButton *_professionButton;
    iCarousel *_itemCarousel;
    PlayerPickerViewController *_playerPicker;
    PlayerAction _turnAction;
    UIPopoverController *_popover;
}

@property (nonatomic, strong) Player *currentPlayer;
@property (nonatomic, readonly) UIPopoverController *popover;

- (void)pressedTrade:(id)sender;
- (void)setReceivingPlayer:(Player *)player;

@end
