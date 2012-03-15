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

@end
