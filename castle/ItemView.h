//
//  ItemView.h
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemView : UIView {
    UILabel *_nameLabel;
    UITextView *_descriptionView;
    UIButton *_tradeButton;
}

@property (nonatomic, strong) NSDictionary *item;

- (id)initWithItem:(NSDictionary *)item;

@end
