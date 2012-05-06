//
//  AppDelegate.h
//  castle
//
//  Created by Ethan Sherbondy on 3/14/12.
//  Copyright (c) 2012 Unidextrous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "WindowManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    WindowManager *_windowManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
