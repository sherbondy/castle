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
    NSArray *itemCards = [items objectFromJSONData];
    NSLog(@"%@", [itemCards objectAtIndex:0]);
    
    self = [super initWithCards:itemCards];
    [self shuffle];
    
    NSLog(@"%@", [[self cards] objectAtIndex:0]);
    
    return self;
}

@end
