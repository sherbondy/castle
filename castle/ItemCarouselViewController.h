//
//  ItemCarouselViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Player.h"
#import "ItemView.h"

@interface ItemCarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, ItemViewDelegate> {
    iCarousel *_itemCarousel;
}

@property (nonatomic, strong) Player *player;

- (void)pressedTrade:(ItemView *)itemView;
- (id)initWithPlayer:(Player *)player;
- (void)setPlayer:(Player *)player;

@end
