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
    if (!_affiliation){
        _affiliation = affiliation;
    }
}

- (NSString *)teamName {
    if (self.affiliation == kOrderTeam){
        return @"The Order of Open Secrets";
    }
    return @"The Brotherhood of True Lies";
}

- (NSString *)shortTeamName {
    // oh how I loathe your verbosity, objective-c
    return [[[[self teamName] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]] componentsJoinedByString:@" "];
}

- (NSString *)teamDescription {
    NSString *itemRequired = @"Goblets";
    if (self.affiliation == kOrderTeam){
        itemRequired = @"Keys";
    }
    return [NSString stringWithFormat:@"If %@ holds at least 3 %@, you may proclaim victory.",
            self.shortTeamName, itemRequired];
}

- (void)setProfession:(NSDictionary *)profession {
    _profession = profession;
    _professionRevealed = NO;
}

- (NSArray *)items {
    return _items;
}

- (NSUInteger)handSize {
    return _items.count;
}

@end
