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

@interface TurnViewController : UIViewController <iCarouselDataSource, iCarouselDelegate> {
    UILabel *_affiliationLabel;
    UILabel *_professionLabel;
    iCarousel *_itemCarousel;
}

@property (nonatomic, strong) Player *currentPlayer;

@end
