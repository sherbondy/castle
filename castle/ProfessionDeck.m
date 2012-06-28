//
//  ProfessionDeck.m
//  castle
//
//  Created by Ethan Sherbondy on 3/23/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "ProfessionDeck.h"
#import "JSONKit.h"

@implementation ProfessionDeck

- (id)init {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"professions" ofType:@"json"];
    NSData *professions = [NSData dataWithContentsOfFile:filePath];
    NSArray *professionCards = [NSMutableArray arrayWithArray:[professions objectFromJSONData]];

    if (self = [super initWithCards:professionCards]){
        [self shuffle];
    }
    
    return self;
}

@end
