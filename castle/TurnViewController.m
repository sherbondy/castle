//
//  TurnViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "TurnViewController.h"
#import "Game.h"
#import "ItemView.h"
#import "DescriptionViewController.h"

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
    [duelButton addTarget:self action:@selector(pressedDuel:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *spyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [spyButton setTitle:@"Spy" forState:UIControlStateNormal];
    [spyButton setFrame:CGRectMake(self.view.width-130-20, self.view.height-64, 130, 48)];
    spyButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleMargins;
    [spyButton addTarget:self action:@selector(pressedSpy:) forControlEvents:UIControlEventTouchUpInside];
    
    _affiliationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 24)];
    _affiliationLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _professionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width-160, 0, 120, 24)];
    _professionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    _professionLabel.textAlignment = UITextAlignmentRight;
    UIButton *professionButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [professionButton addTarget:self action:@selector(getProfessionDescription:)
               forControlEvents:UIControlEventTouchUpInside];
    professionButton.frame = CGRectMake(self.view.width-28, 4, 24, 24);
    
    _itemCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 32, self.view.width, self.view.height-96)];
    _itemCarousel.delegate = self;
    _itemCarousel.dataSource = self;
    _itemCarousel.type = iCarouselTypeLinear;
    _itemCarousel.autoresizingMask = UIViewAutoresizingAll;
    
    _playerPicker = [[PlayerPickerViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.view addSubviews:duelButton, spyButton, _affiliationLabel,
                           _professionLabel, _itemCarousel, professionButton, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _currentPlayer = [Game sharedGame].currentPlayer;
    if (_currentPlayer) {
        _affiliationLabel.text = _currentPlayer.teamName;
        _professionLabel.text = [_currentPlayer.profession objectForKey:@"title"];
        [_itemCarousel reloadData];
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


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.currentPlayer.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {

    ItemView *itemView;
    NSDictionary *theItem = [self.currentPlayer.items objectAtIndex:index];
    if (!view) {
        itemView = [[ItemView alloc] initWithItem:theItem andDelegate:self];
    } else {
        itemView = (ItemView *)view;
        itemView.item = theItem;
    }
    
    return itemView;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 150;
}

- (void)presentPlayerPickerWithAction:(PlayerAction)action {
    _playerPicker.action = action;
    UINavigationController *playerPickerNav = [[UINavigationController alloc] initWithRootViewController:_playerPicker];
    [self presentModalViewController:playerPickerNav animated:YES];
}

- (void)pressedDuel:(id)sender {
    NSLog(@"Duel time.");
    [self presentPlayerPickerWithAction:kDuelAction];
}

- (void)pressedSpy:(id)sender {
    NSLog(@"Spy time.");
    [self presentPlayerPickerWithAction:kSpyAction];
}

- (void)pressedTrade:(id)sender {
    NSLog(@"Trade offered");
    [self presentPlayerPickerWithAction:kTradeAction];
}

- (void)getProfessionDescription:(id)sender {
    NSDictionary *profession = self.currentPlayer.profession;
    DescriptionViewController *descriptionVC = [[DescriptionViewController alloc] initWithTitle:[profession objectForKey:@"title"] andDescription:[profession objectForKey:@"description"]];
    UINavigationController *descriptionNav = [[UINavigationController alloc] initWithRootViewController:descriptionVC];
    // if iPad, show popover instead
    [self presentModalViewController:descriptionNav animated:YES];
}

@end
