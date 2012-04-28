//
//  ItemDeck.m
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "ItemDeck.h"
#import "JSONKit.h"
#import "Item.h"

@implementation ItemDeck

- (id)init {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"json"];
    NSData *items = [NSData dataWithContentsOfFile:filePath];                       
    NSArray *itemCards = [NSMutableArray arrayWithArray:[items objectFromJSONData]];
    
    NSMutableArray *realCards = [NSMutableArray array];
    for (NSDictionary *card in itemCards){
        [realCards addObject:[Item fromDictionary:card]];

        if ([card objectForKey:@"count"]){
            NSInteger count = [[card objectForKey:@"count"] integerValue];

            while (count > 1) {
                [realCards addObject:[Item fromDictionary:card]];
                count -= 1;
            }
        }
    }
        
    self = [super initWithCards:realCards];
    [self shuffle];

    NSLog(@"Number of cards: %i", self.count);
        
    return self;
}

- (NSMutableArray *)drawStartingObjectsForPlayerCount:(NSUInteger)playerCount {
    int desiredKeyCount = playerCount < 8 ? 1 : 2;
    int desiredGobletCount = playerCount < 8 ? 1 : 2;
    int i = 0;
    
    NSMutableIndexSet *indicesToDrawFrom = [NSMutableIndexSet new];
    for (Item *card in self.cards){
        if (card.id == 0 && desiredKeyCount > 0){
            [indicesToDrawFrom addIndex:i];
            desiredKeyCount -= 1;
        } else if (card.id == 1 && desiredGobletCount > 0){
            [indicesToDrawFrom addIndex:i];
            desiredGobletCount -= 1;
        } else if (card.id == 2 || card.id == 3){
            [indicesToDrawFrom addIndex:i];
        }
        i++;
    }
    
    NSMutableArray *startingObjects = [NSMutableArray arrayWithArray:[self drawCardsAtIndics:indicesToDrawFrom]];
        
    while (startingObjects.count < playerCount) {
        [startingObjects addObject:[self drawCard]];
    }
            
    return startingObjects;
}

@end
