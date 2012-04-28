//
//  CastleTestController.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "CastleTestController.h"
#import "KIFTestScenario+CastleAdditions.h"

@implementation CastleTestController

- (void)initializeScenarios {
    [self addScenario:[KIFTestScenario scenarioToStartGame]];
}

@end
