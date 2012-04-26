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
    UILabel *_affiliationLabel;
    UIButton *_professionButton;
    iCarousel *_itemCarousel;
    PlayerPickerViewController *_playerPicker;
    PlayerAction _turnAction;
}

@property (nonatomic, strong) Player *currentPlayer;

- (void)pressedTrade:(id)sender;
- (void)setReceivingPlayer:(Player *)player;

@end
