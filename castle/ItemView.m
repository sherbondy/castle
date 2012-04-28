//
//  ItemView.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "ItemView.h"
#import "Game.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,0,(self.width-16), 24)];
        _descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0,32, self.width, (self.height-64))];
        _descriptionView.editable = NO;
        _tradeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _tradeButton.frame = CGRectMake(0, self.height-40, self.width, 32);
        [_tradeButton setTitle:@"Trade" forState:UIControlStateNormal];
        
        [self addSubviews:_nameLabel, _descriptionView, _tradeButton, nil];
    }
    return self;
}

- (id)initWithItem:(Item *)item andDelegate:(id)delegate {
    self = [self initWithFrame:CGRectMake(0,0,150,200)];
    if (self){
        self.delegate = delegate;
        self.item = item;
        _nameLabel.text = item.name;
        _descriptionView.text = item.description;
        [_tradeButton addTarget:self action:@selector(pressedTrade:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)pressedTrade:(id)sender {
    [self.delegate pressedTrade:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
