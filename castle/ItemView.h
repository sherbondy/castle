//
//  ItemView.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@class ItemView;

@protocol ItemViewDelegate
- (void)pressedTrade:(ItemView *)itemView;
@end


@interface ItemView : UIView {
    UILabel *_nameLabel;
    UITextView *_descriptionView;
    UIButton *_tradeButton;
}

@property (nonatomic, strong) Item *item;
@property (nonatomic, weak) id<ItemViewDelegate> delegate;

- (id)initWithItem:(Item *)item andDelegate:(id)delegate;

@end