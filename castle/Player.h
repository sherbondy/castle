//
//  Player.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	kOrderTeam = 0,
	kBrotherHoodTeam = 1,
};
typedef NSUInteger Affiliation;

@interface Player : NSObject {
    @private
    NSString *_character;
    NSMutableArray *_items;
    Affiliation _affiliation;
    BOOL _professionRevealed;
}

@property (nonatomic, strong)   NSString     *character;
@property (nonatomic, strong)   NSString     *name;
@property (nonatomic, readonly) NSUInteger    handSize;
@property (nonatomic, readonly) Affiliation   affiliation;
@property (nonatomic, readonly) NSString     *teamName;
@property (nonatomic, readonly) NSString     *shortTeamName;
@property (nonatomic, readonly) NSString     *teamDescription;
@property (nonatomic, strong)   NSDictionary *profession;
@property (nonatomic, assign)   BOOL          professionRevealed;
@property (nonatomic, readonly) NSArray      *items;
@property (nonatomic, assign)   NSUInteger    pityTokens;

+ (UIImage *)imageForCharacter:(NSString *)character;

- (id)initWithName:(NSString *)name;
- (UIImage *)characterImage;
- (NSString *)teamName;
- (NSArray *)items;
- (void)addItemToHand:(id)item;
- (void)removeItemFromHand:(id)item;
- (NSUInteger)countOfItems;
- (id)objectInItemsAtIndex:(NSUInteger)index;
- (void)insertObject:(NSDictionary *)object inItemsAtIndex:(NSUInteger)index;
- (void)removeObjectFromItemsAtIndex:(NSUInteger)index;
- (void)setAffiliation:(Affiliation)affiliation;

@end
