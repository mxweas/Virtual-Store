//
//  LeftDoor.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DoorLight.h"

@interface LeftDoor : CCSprite {
    DoorLight *greenLight;
    DoorLight *redLight;
}

@property (nonatomic, readonly) DoorLight *greenLight;
@property (nonatomic, readonly) DoorLight *redLight;

@end
