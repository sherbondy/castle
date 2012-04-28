//
//  Item.h
//  castle
//
//  Created by Ethan Sherbondy on 4/27/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCopying>

@property (nonatomic, readonly) NSUInteger   id;
@property (nonatomic, readonly) NSString    *name;
@property (nonatomic, readonly) NSString    *description;
@property (nonatomic, readonly) BOOL         mustAccept;
@property (nonatomic, readonly) BOOL         isBag;

+ (Item *)fromDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
