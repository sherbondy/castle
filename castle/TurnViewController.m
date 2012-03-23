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
    
    _itemCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 32, self.view.width, self.view.height-96)];
    _itemCarousel.delegate = self;
    _itemCarousel.dataSource = self;
    _itemCarousel.type = iCarouselTypeLinear;
    _itemCarousel.autoresizingMask = UIViewAutoresizingAll;
    
    [self.view addSubviews:duelButton, spyButton, _affiliationLabel, _professionLabel, _itemCarousel];
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
        itemView = [[ItemView alloc] initWithItem:theItem];
    } else {
        itemView = (ItemView *)view;
        itemView.item = theItem;
    }
    
    return itemView;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 150;
}

@end
