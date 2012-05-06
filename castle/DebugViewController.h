//
//  DebugViewController.h
//  castle
//
//  Created by Ethan Sherbondy on 5/5/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField  *textField;
@property (nonatomic, strong) UITextView   *textView;

@end
