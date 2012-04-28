//
//  Item.m
//  castle
//
//  Created by Ethan Sherbondy on 4/27/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize id = _id;
@synthesize name = _name;
@synthesize description = _description;

+ (Item *)fromDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self){
        _id = [[dictionary objectForKey:@"id"] intValue];
        _name = [dictionary objectForKey:@"name"];
        _description = [dictionary objectForKey:@"description"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [Item fromDictionary:[NSDictionary dictionaryWithObjects:@[[NSNumber numberWithUnsignedInteger:_id], _name, _description]
                                                            forKeys:@[@"id",@"name",@"description"]]];
}

- (BOOL)mustAccept {
    return (self.id == 14 || self.id == 15);
}

- (BOOL)isBag {
    return (self.id == 2 || self.id == 3);
}

@end
