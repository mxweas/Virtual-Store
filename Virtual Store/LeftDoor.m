//
//  LeftDoor.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftDoor.h"


@implementation LeftDoor

@synthesize greenLight;
@synthesize redLight;

- (id)init {
    if ((self = [super init]) != nil) {
        greenLight = [[DoorLight alloc] initWithLightColor:DoorLightGreen];
        greenLight.position = ccp(351.0f, 454.0f);
        //greenLight.isOn = YES;
        //greenLight.isBlinking = YES;
        [self addChild:greenLight];
        redLight = [[DoorLight alloc] initWithLightColor:DoorLightRed];
        redLight.position = ccp(411.0f, 454.0f);
        //redLight.isBlinking = YES;
        [self addChild:redLight];
    }
    return self;
}

- (void)dealloc {
    [self removeChild:greenLight cleanup:YES];
    [greenLight release];
    [self removeChild:redLight cleanup:YES];
    [redLight release];
    [super dealloc];
}

@end
