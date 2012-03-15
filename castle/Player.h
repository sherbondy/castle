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
    NSMutableArray *_items;
}

@property (nonatomic, strong)   NSString   *character;
@property (nonatomic, strong)   NSString   *name;
@property (nonatomic, readonly) NSUInteger handSize;

+ (UIImage *)imageForCharacter:(NSString *)character;

- (id)initWithName:(NSString *)name;
- (UIImage *)characterImage;
- (void)addItemToHand:(id)item;

@end
