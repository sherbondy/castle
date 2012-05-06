//
//  WindowManager.h
//  castle
//
//  Created by Ethan Sherbondy on 5/5/12.
//  Copyright (c) 2012 MIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DebugViewController.h"

@interface WindowManager : NSObject {
    UIWindow *_secondWindow;
    DebugViewController *_debugVC;
}

- (void)setupSecondScreen:(UIScreen *)newScreen;

@end
