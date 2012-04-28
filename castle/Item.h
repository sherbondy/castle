//
//  Item.h
//  castle
//
//  Created by Ethan Sherbondy on 4/27/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSUInteger kTome = 9;
static NSUInteger kMonocle = 10;
static NSUInteger kPriviledge = 11;
static NSUInteger kCoat = 12;
static NSUInteger kSextant = 13;
static NSUInteger kShatteredMirror = 14;
static NSUInteger kBlackPearl = 15;
static NSUInteger kSealOfTheLodge = 16;

@interface Item : NSObject <NSCopying>

@property (nonatomic, readonly) NSUInteger   id;
@property (nonatomic, readonly) NSString    *name;
@property (nonatomic, readonly) NSString    *description;
@property (nonatomic, readonly) BOOL         mustAccept;
@property (nonatomic, readonly) BOOL         isBag;

+ (Item *)fromDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (BOOL (^)(id))checkerFor:(NSUInteger)card;

@end
