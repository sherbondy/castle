//
//  AcceptTradeViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCarouselViewController.h"

@interface AcceptTradeViewController : UIViewController {
    ItemCarouselViewController *_itemCarouselVC;
    UIButton *_offerButton;
    UIButton *_declineButton;
}

- (void)pressedTrade:(ItemView *)itemView;
- (void)updateOffer;

@end
