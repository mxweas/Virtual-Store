//
//  VirtualStoreAppDelegate.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VirtualStoreAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
