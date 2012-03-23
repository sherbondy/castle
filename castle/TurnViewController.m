//
//  TurnViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "TurnViewController.h"
#import "Game.h"

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
    duelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleMargins;

    UIButton *spyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [spyButton setTitle:@"Spy" forState:UIControlStateNormal];
    [spyButton setFrame:CGRectMake(170, self.view.height-64, 130, 48)];
    spyButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleMargins;
    
    _affiliationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 24)];
    _affiliationLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _professionLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, 24)];
    _professionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    _professionLabel.textAlignment = UITextAlignmentRight;
    
    [self.view addSubview:duelButton];
    [self.view addSubview:spyButton];
    [self.view addSubview:_affiliationLabel];
    [self.view addSubview:_professionLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    Player *currentPlayer = [Game sharedGame].currentPlayer;
    if (currentPlayer) {
        _affiliationLabel.text = currentPlayer.teamName;
        _professionLabel.text = [currentPlayer.profession objectForKey:@"title"];
    }
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
