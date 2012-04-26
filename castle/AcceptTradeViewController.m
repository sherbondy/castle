//
//  AcceptTradeViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "AcceptTradeViewController.h"
#import "Game.h"

@interface AcceptTradeViewController ()

@end

@implementation AcceptTradeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *description = [[UILabel alloc] init];
    [description setFrame: CGRectMake(0, 0, self.view.width, 32)];
    description.text = [NSString stringWithFormat:@"Offered: %@", [Game sharedGame].offeredItem];
    [self.view addSubview:description];
    // add view to show the offered item
    // add view to select counter-offer, or press decline.
    UIButton *declineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height-32, self.view.width, 32)];
    [self.view addSubview:declineButton];
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
