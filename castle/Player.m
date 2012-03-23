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
@synthesize affiliation = _affiliation;

+ (UIImage *)imageForCharacter:(NSString *)character {
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [[[character componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] objectAtIndex:0] lowercaseString]];
    return [UIImage imageNamed:imageName];
}

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

- (UIImage *)characterImage {
    return [Player imageForCharacter:_character];
}

- (void)addItemToHand:(id)item {
    if (!_items){
        _items = [NSMutableArray arrayWithObject:item];
    } else {
        [_items addObject:item];
    }
}

- (void)setAffiliation:(Affiliation)affiliation {
    _affiliation = affiliation;
}

- (NSString *)teamName {
    if (self.affiliation == kOrderTeam){
        return @"The Order of Open Secrets";
    }
    return @"The Brotherhood of True Lies";
}

- (NSUInteger)handSize {
    return _items.count;
}

@end
