//
//  AcceptTradeViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCarouselViewController.h"

@interface AcceptTradeViewController : UIViewController {
    ItemCarouselViewController *_itemCarouselVC;
    UIButton *_offerButton;
}

- (void)pressedTrade:(ItemView *)itemView;
- (void)registerObservers;

@end
