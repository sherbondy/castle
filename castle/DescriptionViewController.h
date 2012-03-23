//
//  DescriptionViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController {
    UITextView *_descriptionView;
}

@property (nonatomic, strong) NSString *description;

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description;

@end
