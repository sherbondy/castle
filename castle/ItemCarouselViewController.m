//
//  ItemCarouselViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "ItemCarouselViewController.h"
#import "Item.h"

@interface ItemCarouselViewController ()

@end

@implementation ItemCarouselViewController

@synthesize items = _items;

- (id)init {
    self = [super init];
    if (self){
        _itemCarousel = [[iCarousel alloc] init];
        _itemCarousel.delegate = self;
        _itemCarousel.dataSource = self;
        _itemCarousel.type = iCarouselTypeLinear;
        _itemCarousel.autoresizingMask = UIViewAutoresizingAll;
        self.view = _itemCarousel;
    }
    return self;
}

- (id)initWithPlayer:(Player *)player {
    self = [self init];
    if (self){
        _player = player;
        [_player addObserver:self forKeyPath:@"items" options:0 context:NULL];
    }
    return self;
}

- (NSArray *)items {
    return _player.items;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self cleanupObserver];
}

- (void)cleanupObserver {
    if (_player) {
        [_player removeObserver:self forKeyPath:@"items"];
    }
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    ItemView *itemView;
    Item *theItem = [self.items objectAtIndex:index];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"items"]){
        [_itemCarousel reloadData];
    }
}

- (void)setPlayer:(Player *)player {
    [self cleanupObserver];
    _player = player;
    [_player addObserver:self forKeyPath:@"items" options:0 context:NULL];
    [_itemCarousel reloadData];
}

- (void)pressedTrade:(ItemView *)itemView {
    if (self.parentViewController){
        [self.parentViewController performSelector:@selector(pressedTrade:) withObject:itemView];
    }
}

@end
