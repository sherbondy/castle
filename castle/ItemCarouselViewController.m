//
//  ItemCarouselViewController.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "ItemCarouselViewController.h"

@interface ItemCarouselViewController ()

@end

@implementation ItemCarouselViewController

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
        _items = player.items;
    }
    return self;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    ItemView *itemView;
    NSDictionary *theItem = [_items objectAtIndex:index];
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

- (void)setPlayer:(Player *)player {
    _items = player.items;
    [_itemCarousel reloadData];
}

- (void)pressedTrade:(ItemView *)itemView {
    if (self.parentViewController){
        [self.parentViewController performSelector:@selector(pressedTrade:) withObject:itemView];
    }
}

@end
