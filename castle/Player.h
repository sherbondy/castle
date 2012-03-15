//
//  Player.h
//  castle
//
//  Created by Ethan Sherbondy on 3/15/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject {
    @private
    NSString *_character;
}

@property (nonatomic, strong) NSString *character;
@property (nonatomic, strong) NSString *name;

- (id)initWithName:(NSString *)name;

@end
