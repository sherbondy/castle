//
//  PlayerPickerViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

enum {
	kDuelAction = 0,
	kSpyAction = 1,
    kTradeAction = 2,
};
typedef NSUInteger PlayerAction;

@interface PlayerPickerViewController : UITableViewController {
    @private
    Player *_receivingPlayer;
    NSIndexPath *_checkedPath;
}

@property (nonatomic, assign) PlayerAction action;

@end
