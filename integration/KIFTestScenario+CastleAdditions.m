//
//  KIFTestScenario+CastleAdditions.m
//  castle
//
//  Created by Ethan Sherbondy on 4/26/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import "KIFTestScenario+CastleAdditions.h"
#import "KIFTestStep.h"

@implementation KIFTestScenario (CastleAdditions)

+ (id)scenarioToStartGame;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a game can be started."];
    // [scenario addStep:[KIFTestStep stepToReset]];
    // [scenario addStepsFromArray:[KIFTestStep stepsToGoToLoginPage]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Player Count Stepper"]];
    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Player Count" value:@"7" traits:UIAccessibilityTraitStaticText]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Done"]];

    [scenario addStep:[KIFTestStep stepToEnterText:@"Ethan" intoViewWithAccessibilityLabel:@"User Name"]];

    int i = 7;
    while (i != 0){
        [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Next"]];
        i--;
    }

    // Verify that the login succeeded
    // [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Welcome"]];
    
    return scenario;
}

@end
