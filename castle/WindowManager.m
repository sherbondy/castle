//
//  WindowManager.m
//  castle
//
//  Created by Ethan Sherbondy on 5/5/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import "WindowManager.h"

@implementation WindowManager

- (id)init {
    self = [super init];
    if (self){
        _debugVC = [[DebugViewController alloc] init];
        [self setupScreenConnectionNotificationHandlers];

        // check if second screen is already connected
        if ([UIScreen screens].count > 1){
            [self setupSecondScreen:[[UIScreen screens] objectAtIndex:1]];
        }
    }
    return self;
}

- (void)setupScreenConnectionNotificationHandlers {
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleScreenConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenModeChangeNotification:)
                   name:UIScreenModeDidChangeNotification object:nil];
}

- (void)handleScreenConnectNotification:(NSNotification *)aNotification {
    UIScreen    *newScreen = [aNotification object];    
    [self setupSecondScreen:newScreen];
}

- (void)setupSecondScreen:(UIScreen *)newScreen {
    if (!_secondWindow) {
        _secondWindow = [[UIWindow alloc] initWithFrame:newScreen.bounds];
        NSLog(@"New screen bounds: %@", NSStringFromCGRect(newScreen.bounds));
        _secondWindow.screen = newScreen;
        _secondWindow.opaque = YES;
        _secondWindow.hidden = NO;
        _secondWindow.backgroundColor = [UIColor whiteColor];
        NSLog(@"Adding second window");
        
        // Set the initial UI for the window.
        _debugVC.view.frame = _secondWindow.frame;
        [_secondWindow addSubview:_debugVC.view];
    } else {
        _secondWindow.screen = newScreen;
    }
}

- (void)handleScreenDisconnectNotification:(NSNotification *)aNotification {
    if (_secondWindow) {
        // Hide and then delete the window.
        _secondWindow.hidden = YES;
        _secondWindow = nil;
        NSLog(@"Disconnecting");
        
        // Update the main screen based on what is showing here.
        
    }

}

- (void)handleScreenModeChangeNotification:(NSNotification *)aNotification {
    NSLog(@"Screen Mode changed");
}

@end
