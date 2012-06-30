//
//  DescriptionViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "DescriptionViewController.h"
#import "Game.h"

static UIPopoverController *_popOver = nil;

@implementation DescriptionViewController

+ (void)initialize {
    if ([UIDevice isPad]){
        _popOver = [[UIPopoverController alloc] init];
    }
}

- (id)init {
    self = [super init];
    if (self){
        self.contentSizeForViewInPopover = CGSizeMake(320, 320);
        _descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.view.height)];
        _descriptionView.autoresizingMask = UIViewAutoresizingAll;
        _descriptionView.editable = NO;
        [_descriptionView setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:_descriptionView];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];

    }
    return self;
}

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description {
    self = [self init];
    if (self){
        self.title = title;
        self.description = description;
    }
    return self;
}

- (void)setDescription:(NSString *)description {
    _description = description;
    _descriptionView.text = description;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)done {
    if ([UIDevice isPad]) {
        // what a mess. Why is there no dismissPopoverControllerAnimated?
        [_popOver dismissPopoverAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}


+ (void)viewController:(UIViewController *)aVC presentDescriptionWithTitle:(NSString *)title
        andDescription:(NSString *)description fromSender:(id)sender
{
    DescriptionViewController *descriptionVC = [[DescriptionViewController alloc] initWithTitle:title
                                                                                 andDescription:description];
    
    UINavigationController *descriptionNav = [[UINavigationController alloc] initWithRootViewController:descriptionVC];
    UIControl *senderControl = (UIControl *)sender;
    
    // if iPad, show popover instead
    if ([UIDevice isPad]) {
        [_popOver setContentViewController:descriptionNav];
        [_popOver presentPopoverFromRect:senderControl.frame inView:aVC.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [aVC presentModalViewController:descriptionNav animated:YES];
    }
}

@end
