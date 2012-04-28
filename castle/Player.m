//
//  Player.m
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "Player.h"
#import "Item.h"

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
        self.pityTokens = 0;
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

// adding KVO-compatibility to items
- (NSUInteger)countOfItems { return _items.count; }
- (id)objectInItemsAtIndex:(NSUInteger)index { return [_items objectAtIndex:index]; }
- (void)insertObject:(Item *)object inItemsAtIndex:(NSUInteger)index {
    [_items insertObject:object atIndex:index];
}
- (void)removeObjectFromItemsAtIndex:(NSUInteger)index {
    [_items removeObjectAtIndex:index];
}

- (void)addItemToHand:(id)item {
    if (!_items){
        _items = [NSMutableArray arrayWithObject:item];
    } else {
        [self insertObject:item inItemsAtIndex:0];
    }
}
- (void)removeItemFromHand:(id)item {
    assert([_items containsObject:item]);
    [self removeObjectFromItemsAtIndex:[_items indexOfObject:item]];
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
