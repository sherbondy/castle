//
//  DescriptionViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController {
    UITextView *_descriptionView;
}

@property (nonatomic, strong) NSString *description;

+ (void)viewController:(UIViewController *)aVC presentDescriptionWithTitle:(NSString *)title andDescription:(NSString *)description fromSender:(id)sender;

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description;

@end
