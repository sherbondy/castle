//
//  CharacterPickerViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CharacterPickerViewController : UIViewController <iCarouselDataSource, iCarouselDelegate> {
    UILabel *_playerNameLabel;
    NSMutableArray *_characters;
    iCarousel *_carousel;
}

@end
