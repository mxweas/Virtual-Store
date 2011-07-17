//
//  StoreWorld.h
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "CC3World.h"
#import "CC3Camera.h"
#import "cocos2d.h"

@interface StoreWorld : CC3World {
    CC3Camera *camera;
    CMMotionManager *motionManager;
    CC3MeshNode *leftWall;
    CC3MeshNode *rightWall;
}

- (void)loadProducts:(NSArray *)products;

@end
