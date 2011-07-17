//
//  main.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VirtualStoreAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [VirtualStoreAppDelegate class];
    int retVal = UIApplicationMain(argc, argv, nil, @"VirtualStoreAppDelegate");
    [pool release];
    return retVal;
}
