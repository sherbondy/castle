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
    NSArray *cards = [items objectFromJSONData];
    NSLog(@"%@", [cards objectAtIndex:0]);
    
    self = [super initWithCards:cards];
    return self;
}

@end
