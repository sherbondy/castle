//
//  AcceptTradeViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "AcceptTradeViewController.h"
#import "DescriptionViewController.h"
#import "Game.h"
#import "Item.h"

@interface AcceptTradeViewController ()

@end

@implementation AcceptTradeViewController

- (id) init {
    self = [super init];
    if (self){
        _offerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _declineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _itemCarouselVC = [[ItemCarouselViewController alloc] init];
        [self addChildViewController:_itemCarouselVC];
    }
    return self;
}

- (void)registerObservers {
    [[Game sharedGame] addObserver:self forKeyPath:@"receivingPlayer" options:0 context:NULL];
    [[Game sharedGame] addObserver:self forKeyPath:@"offeredItem" options:0 context:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _offerButton.frame = CGRectMake(0, 0, self.view.width, 32);
    [_offerButton addTarget:self action:@selector(showItemDescription:) forControlEvents:UIControlEventTouchUpInside];
    _itemCarouselVC.view.frame = CGRectMake(0, 96, self.view.width, 240);
    
    // add view to select counter-offer, or press decline.
    _declineButton.frame = CGRectMake(0, self.view.height-32, self.view.width, 32);
    [_declineButton setDefaultTitle:@"Decline"];
    [_declineButton setTitle:@"Must Accept" forState:UIControlStateDisabled];
    [_declineButton addTarget:self action:@selector(declineTrade:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubviews:_offerButton, _itemCarouselVC.view, _declineButton, nil];
}

- (void)viewDidUnload {
    [[Game sharedGame] removeObserver:self forKeyPath:@"receivingPlayer"];
    [[Game sharedGame] removeObserver:self forKeyPath:@"offeredItem"];
}

- (void)updateOffer {
    [_offerButton setDefaultTitle:[NSString stringWithFormat:@"Offered: %@",
                                   [Game sharedGame].offeredItem.name]];
    _declineButton.enabled = ![Game sharedGame].offeredItem.mustAccept;
}

- (void)showItemDescription:(id)sender {
    Item *offeredItem = [Game sharedGame].offeredItem;
    [DescriptionViewController viewController:self
                  presentDescriptionWithTitle:offeredItem.name
                               andDescription:offeredItem.description fromSender:sender];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"receivingPlayer"]){
        [_itemCarouselVC setPlayer:[Game sharedGame].receivingPlayer];
    } else if ([keyPath isEqual:@"offeredItem"]) {
        [self updateOffer];
    }
}

- (void)pressedTrade:(ItemView *)itemView {
    NSLog(@"Trading back: %@", itemView.item);
    // cannot trade two bags
    if (itemView.item.isBag && [Game sharedGame].offeredItem.isBag) {
        NSLog(@"Cannot do that");
    } else {
        [[Game sharedGame] acceptTradeWithItem:itemView.item];
    }
}

- (void)declineTrade:(id)sender {
    NSLog(@"Decline trade");
    [[Game sharedGame] declineTrade];
}

@end
