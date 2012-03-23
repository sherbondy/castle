//
//  ItemDeck.m
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "ItemDeck.h"
#import "JSONKit.h"

@implementation ItemDeck

// Need to implement the red and green seal mechanic for distributing cards!

- (id)init {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"json"];
    NSData *items = [NSData dataWithContentsOfFile:filePath];                       
    NSArray *itemCards = [NSMutableArray arrayWithArray:[items objectFromJSONData]];
    
    NSMutableArray *duplicateCards = [NSMutableArray array];
    for (NSDictionary *card in itemCards){
        if ([card objectForKey:@"count"]){
            NSInteger count = [[card objectForKey:@"count"] integerValue];

            while (count > 1) {
                [duplicateCards addObject:[card copy]];
                count -= 1;
            }
        }
    }
    
    itemCards = [itemCards arrayByAddingObjectsFromArray:duplicateCards];
    
    self = [super initWithCards:itemCards];
    [self shuffle];
        
    return self;
}

- (NSMutableArray *)drawStartingObjectsForPlayerCount:(NSUInteger)playerCount {
    int desiredKeyCount = playerCount < 8 ? 1 : 2;
    int desiredGobletCount = playerCount < 8 ? 1 : 2;
    int i = 0;
    
    NSMutableIndexSet *indicesToDrawFrom = [NSMutableIndexSet new];
    for (NSDictionary *card in self.cards){
        NSUInteger cardID = [[card objectForKey:@"id"] integerValue];
        if (cardID == 0 && desiredKeyCount > 0){
            [indicesToDrawFrom addIndex:i];
            desiredKeyCount -= 1;
        } else if (cardID == 1 && desiredGobletCount > 0){
            [indicesToDrawFrom addIndex:i];
            desiredGobletCount -= 1;
        } else if (cardID == 2 || cardID == 3){
            [indicesToDrawFrom addIndex:i];
        }
        i++;
    }
    
    NSMutableArray *startingObjects = [NSMutableArray arrayWithArray:[self drawCardsAtIndics:indicesToDrawFrom]];
        
    while (startingObjects.count < playerCount) {
        [startingObjects addObject:[self drawCard]];
    }
    
    NSLog(@"%@", startingObjects);
        
    return startingObjects;
}

@end
