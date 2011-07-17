//
//  DoorsLayer.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LeftDoor.h"

@interface DoorsLayer : CCLayer {
    LeftDoor *leftDoor;
    CCSprite *rightDoor;
    BOOL doorsOpen;
}

@property (nonatomic, readonly) LeftDoor *leftDoor;
@property (nonatomic, assign) BOOL doorsOpen;

- (void)setDoorsOpen:(BOOL)doorsOpen animated:(BOOL)animated;

@end
