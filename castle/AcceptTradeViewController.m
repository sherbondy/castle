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

- (id) init {
    self = [super init];
    if (self){
        _offerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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

    [_offerButton setFrame: CGRectMake(0, 0, self.view.width, 32)];
    [_offerButton addTarget:self action:@selector(showItemDescription:) forControlEvents:UIControlEventTouchUpInside];
    _itemCarouselVC.view.frame = CGRectMake(0, 96, self.view.width, 240);
    
    // add view to select counter-offer, or press decline.
    UIButton *declineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    declineButton.frame = CGRectMake(0, self.view.height-32, self.view.width, 32);
    [declineButton setDefaultTitle:@"Decline"];
    [declineButton addTarget:self action:@selector(declineTrade:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubviews:_offerButton, _itemCarouselVC.view, declineButton, nil];
}

- (void)viewDidUnload {
    [[Game sharedGame] removeObserver:self forKeyPath:@"receivingPlayer"];
    [[Game sharedGame] removeObserver:self forKeyPath:@"offeredItem"];
}

- (void)updateOffer {
    [_offerButton setDefaultTitle:[NSString stringWithFormat:@"Offered: %@",
                                   [[Game sharedGame].offeredItem objectForKey:@"name"]]];
}

- (void)showItemDescription:(id)sender {
    NSDictionary *offeredItem = [Game sharedGame].offeredItem;
    [[Game sharedGame].turnVC presentDescriptionWithTitle:[offeredItem
                                                          objectForKey:@"name"]
                                           andDescription:[offeredItem objectForKey:@"description"]
                                               fromSender:sender];

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
}

- (void)declineTrade:(id)sender {
    NSLog(@"Decline trade");
}

@end
