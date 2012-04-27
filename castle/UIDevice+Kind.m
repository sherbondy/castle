//
//  UIDevice+Kind.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "UIDevice+Kind.h"

@implementation UIDevice (Kind)

+ (BOOL) hasIdiom:(UIUserInterfaceIdiom)idiom {
    return [UIDevice currentDevice].userInterfaceIdiom == idiom;
}

+ (BOOL) isPad {
    return [UIDevice hasIdiom:UIUserInterfaceIdiomPad];
}

+ (BOOL) isPhone {
    return [UIDevice hasIdiom:UIUserInterfaceIdiomPhone];
}

@end
