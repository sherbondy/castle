//
//  TurnViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "TurnViewController.h"

@interface TurnViewController ()

@end

@implementation TurnViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    UIButton *duelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [duelButton setTitle:@"Duel" forState:UIControlStateNormal];
    [duelButton setFrame:CGRectMake(20, self.view.height-64, 130, 48)];

    UIButton *spyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [spyButton setTitle:@"Spy" forState:UIControlStateNormal];
    [spyButton setFrame:CGRectMake(170, self.view.height-64, 130, 48)];
    
    [self.view addSubview:duelButton];
    [self.view addSubview:spyButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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

@end
