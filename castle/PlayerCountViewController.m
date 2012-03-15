//
//  PlayerCountViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "PlayerCountViewController.h"
#import "CharacterPickerViewController.h"
#import "Game.h"

@interface PlayerCountViewController ()

@end

@implementation PlayerCountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Players";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next:)];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _stepper = [[UIStepper alloc] init];
    _stepper.frame = CGRectMake((self.view.width - _stepper.width)/2, 
                                (self.view.height - _stepper.height)/2, 
                                _stepper.width, _stepper.height);
    _stepper.minimumValue = 3;
    _stepper.maximumValue = 10;
    _stepper.value = 6;
    _stepper.stepValue = 1;
    _stepper.autoresizingMask = UIViewAutoresizingFlexibleMargins;
    [_stepper addTarget:self action:@selector(updateCount:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_stepper];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 64)];
    _countLabel.textAlignment = UITextAlignmentCenter;
    _countLabel.font = [UIFont systemFontOfSize:32];
    _countLabel.autoresizingMask = UIViewAutoresizingFlexibleMargins;
    [self updateCount:nil];
    [self.view addSubview:_countLabel];
}

- (void)updateCount:(id)sender {
    _countLabel.text = [NSString stringWithFormat:@"%i", (int)_stepper.value];
}

- (void)next:(id)sender {
    [[Game sharedGame] setPlayerCount:(NSUInteger)_stepper.value];
    CharacterPickerViewController *characterPickerVC = [[CharacterPickerViewController alloc] init];
    [self.navigationController pushViewController:characterPickerVC animated:YES];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
