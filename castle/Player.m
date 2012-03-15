//
//  Player.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize character = _character;

- (id)initWithName:(NSString *)name {
    if ((self = [super init])){
        self.name = name;
    }
    return self;
}

- (void)setCharacter:(NSString *)character {
    if (!_character) {
        _character = character;
    }
}

@end
