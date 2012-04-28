//
//  CharacterPickerViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CharacterPickerViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, UITextFieldDelegate> {
    NSMutableArray *_characters;
    iCarousel *_carousel;
    UITextField *_nameField;
}

@end
