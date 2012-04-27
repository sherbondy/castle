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

@synthesize popover = _popover;

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
    
    _affiliationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _affiliationButton.frame = CGRectMake(0, 0, 160, 24);
    [_affiliationButton addTarget:self action:@selector(getAffiliationDescription:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    _professionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _professionButton.frame = CGRectMake(0, 32, 120, 24);
    [_professionButton addTarget:self action:@selector(getProfessionDescription:)
               forControlEvents:UIControlEventTouchUpInside];

    UIButton *gameBoardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gameBoardButton.frame = CGRectMake(self.view.width-140, 0, 140, 64);
    [gameBoardButton setDefaultTitle:@"Show Game Board"];

    _pityTokenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 140, 24)];
    [self updatePityTokenLabel];

    _itemCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-128)];
    _itemCarousel.delegate = self;
    _itemCarousel.dataSource = self;
    _itemCarousel.type = iCarouselTypeLinear;
    _itemCarousel.autoresizingMask = UIViewAutoresizingAll;
    
    _playerPicker = [[PlayerPickerViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.view addSubviews:duelButton, spyButton, _affiliationButton, _pityTokenLabel,
                           _itemCarousel, _professionButton, gameBoardButton, nil];
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
        [_affiliationButton setDefaultTitle:_currentPlayer.shortTeamName];
        [_professionButton setDefaultTitle:[_currentPlayer.profession objectForKey:@"title"]];
        [_itemCarousel reloadData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
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
    _turnAction = action;
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

- (void)setReceivingPlayer:(Player *)player {
    NSLog(@"The receiving player is: %@", player);
    // need state for action type
    switch (_turnAction) {
        case kDuelAction:
            break;
        case kSpyAction:
            NSLog(@"Time to duel.");
            break;
        case kTradeAction:
            NSLog(@"Time to trade.");
            [[Game sharedGame] offerTradeFrom:self.currentPlayer to:player];
            break;

        default:
            break;
    }
}

- (void)updatePityTokenLabel {
    _pityTokenLabel.text = [NSString stringWithFormat:@"%i Pity Token%@",
                            _currentPlayer.pityTokens, (_currentPlayer.pityTokens == 1 ? @"" : @"s")];
}

- (void)getProfessionDescription:(id)sender {
    NSDictionary *profession = self.currentPlayer.profession;
    [self presentDescriptionWithTitle:[profession objectForKey:@"title"]
                       andDescription:[profession objectForKey:@"description"] fromSender:sender];
}

- (void)getAffiliationDescription:(id)sender {
    [self presentDescriptionWithTitle:_currentPlayer.teamName
                       andDescription:_currentPlayer.teamDescription fromSender:sender];
}

- (void)presentDescriptionWithTitle:(NSString *)title andDescription:(NSString *)description fromSender:(id)sender {
    DescriptionViewController *descriptionVC = [[DescriptionViewController alloc] initWithTitle:title
                                                                                 andDescription:description];
    UINavigationController *descriptionNav = [[UINavigationController alloc] initWithRootViewController:descriptionVC];
    // if iPad, show popover instead
    if ([UIDevice isPad]) {
        if (!_popover){
            _popover = [[UIPopoverController alloc] initWithContentViewController:descriptionNav];
        } else {
            [_popover setContentViewController:descriptionNav];
        }
        [_popover presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentModalViewController:descriptionNav animated:YES];
    }
}

@end
