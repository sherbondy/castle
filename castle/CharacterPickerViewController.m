//
//  CharacterPickerViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "CharacterPickerViewController.h"
#import "Game.h"

@interface CharacterPickerViewController ()

@end

@implementation CharacterPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 32)];
    _playerNameLabel.textAlignment = UITextAlignmentCenter;
    [self updatePlayerNameLabel];
    [self.view addSubview:_playerNameLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)updatePlayerNameLabel {
    _playerNameLabel.text = [NSString stringWithFormat:@"Pick your Character, %@", 
                             [[Game sharedGame] currentPlayer].name];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
