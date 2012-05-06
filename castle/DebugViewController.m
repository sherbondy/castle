//
//  DebugViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 5/5/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "DebugViewController.h"
#import "Nu.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)init {
    self = [super init];
    if (self) {
        NuInit();
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor blackColor];

    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-32)];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.textColor = [UIColor whiteColor];
    _textView.autoresizingMask = UIViewAutoResizingFlexibleDimensions;

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.height-32, self.view.width, 32)];
    _textField.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    _textField.textColor = [UIColor whiteColor];
    _textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    _textField.delegate = self;
    
    [self.view addSubviews:_textView, _textField, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
    [_textField becomeFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// have textField take over whenever main application is done using the keyboard.
- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSLog(@"Hiding keboard.");
    [_textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // special single character commands
    if (textField.text.length == 1){

        switch ([textField.text.lowercaseString characterAtIndex:0]) {
            case 'w':
                NSLog(@"Scroll up");
                [_textView setContentOffset:CGPointMake(0, _textView.contentOffset.y-20) animated:YES];
                break;
            case 's':
                NSLog(@"Scroll down");
                [_textView setContentOffset:CGPointMake(0, _textView.contentOffset.y+20) animated:YES];
                break;
            default:
                break;
        }
    } else {
        _textView.text = [NSString stringWithFormat:@"%@\n%@", _textView.text, textField.text];
        NSString *output = [[Nu sharedParser] parseEval:_textView.text];
        _textView.text = [NSString stringWithFormat:@"%@\n> %@", _textView.text, output];
        
        if ([_textField.text.lowercaseString isEqual:@"clear"]){
            _textView.text = @"";
            [_textView setContentOffset:CGPointZero animated:NO];
        }
        _textField.text = @"";
    }
    return YES;
}


@end
