//
//  TurnViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "TurnViewController.h"
#import "Game.h"
#import "DescriptionViewController.h"

@implementation TurnViewController

@synthesize popover = _popover;

- (id)init {
    self = [super init];
    if (self) {
        _affiliationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_affiliationButton addTarget:self action:@selector(getAffiliationDescription:)
                     forControlEvents:UIControlEventTouchUpInside];
        
        _professionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_professionButton addTarget:self action:@selector(getProfessionDescription:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        _pityTokenLabel = [[UILabel alloc] init];
        
        _itemCarouselVC = [[ItemCarouselViewController alloc] init];
        [self addChildViewController:_itemCarouselVC];
    }
    return self;
}

- (void)registerObservers {
    [[Game sharedGame] addObserver:self forKeyPath:@"currentPlayer" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:NULL];
}

- (void)loadView {
    [super loadView];

    _affiliationButton.frame = CGRectMake(0, 0, 160, 24);
    _professionButton.frame = CGRectMake(0, 32, 120, 24);
    _pityTokenLabel.frame = CGRectMake(0, 64, 140, 24);
    _itemCarouselVC.view.frame = CGRectMake(0, 96, self.view.width, 240);
    
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

    UIButton *gameBoardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gameBoardButton.frame = CGRectMake(self.view.width-140, 0, 140, 64);
    [gameBoardButton setDefaultTitle:@"Show Game Board"];

    [self updatePlayerFields];
    
    _playerPicker = [[PlayerPickerViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.view addSubviews:duelButton, spyButton, _affiliationButton, _pityTokenLabel,
                           _itemCarouselVC.view, _professionButton, gameBoardButton, nil];
}

- (Player *)currentPlayer {
    return [Game sharedGame].currentPlayer;
}

- (void)viewDidUnload {
    [[Game sharedGame] removeObserver:self forKeyPath:@"currentPlayer"];
    [[Game sharedGame].currentPlayer removeObserver:self forKeyPath:@"pityTokens"];

}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
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

- (void)pressedTrade:(ItemView *)itemView {
    NSLog(@"Trade offered");
    [[Game sharedGame] setOfferedItem:itemView.item];
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
            [[Game sharedGame] offerTradeTo:player];
            break;

        default:
            break;
    }
}

- (void)updatePityTokenLabel {
    _pityTokenLabel.text = [NSString stringWithFormat:@"%i Pity Token%@",
                            [self currentPlayer].pityTokens, ([self currentPlayer].pityTokens == 1 ? @"" : @"s")];
}
- (void)updatePlayerFields {
    Player *cp = [self currentPlayer];
    [_affiliationButton setDefaultTitle:cp.shortTeamName];
    [_professionButton setDefaultTitle:[cp.profession objectForKey:@"title"]];
    [_itemCarouselVC setPlayer:cp];
    [self updatePityTokenLabel];
}

- (void)getProfessionDescription:(id)sender {
    NSDictionary *profession = self.currentPlayer.profession;
    [DescriptionViewController viewController:self
                  presentDescriptionWithTitle:[profession objectForKey:@"title"]
                               andDescription:[profession objectForKey:@"description"] fromSender:sender];
}

- (void)getAffiliationDescription:(id)sender {
    [DescriptionViewController viewController:self
                  presentDescriptionWithTitle:[self currentPlayer].teamName
                               andDescription:[self currentPlayer].teamDescription fromSender:sender];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"currentPlayer"]){
        id oldPlayer = [change objectForKey:NSKeyValueChangeOldKey];
        if ([oldPlayer isKindOfClass:[Player class]]){
            [oldPlayer removeObserver:self forKeyPath:@"pityTokens"]; // old player
        }
        [[Game sharedGame].currentPlayer addObserver:self forKeyPath:@"pityTokens" options:0 context:NULL];
        [self updatePlayerFields];
    } else if ([keyPath isEqual:@"pityTokens"]){
        [self updatePityTokenLabel];
    }
}

@end
