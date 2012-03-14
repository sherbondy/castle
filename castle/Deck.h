//
//  Deck.h
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject {
    @private
    NSMutableArray *_cards;
}

- (id)init;
- (id)initWithCards:(NSArray *)cards;
- (void)shuffle;
- (id)drawCard;
- (void)placeCardAtTop:(id)card;
- (void)placeCardAtBottom:(id)card;
- (NSArray *)cards;

@end
