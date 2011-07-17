//
//  DoorsLayer.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DoorsLayer.h"


@implementation DoorsLayer

@synthesize leftDoor;
@synthesize doorsOpen;

- (id)init {
    if ((self = [super init]) != nil) {
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
        leftDoor = [[LeftDoor alloc] initWithFile:@"LeftDoor.png"];
        leftDoor.anchorPoint = ccp(1.0f, 0.0f);
        leftDoor.position = ccp(windowSize.width/2.0f, 0.0f);
        [self addChild:leftDoor];
        rightDoor = [[CCSprite alloc] initWithFile:@"RightDoor.png"];
        rightDoor.anchorPoint = ccp(0.0f, 0.0f);
        rightDoor.position = ccp(windowSize.width/2.0f, 0.0f);
        [self addChild:rightDoor];
        doorsOpen = NO;
    }
    return self;
}

- (void)setDoorsOpen:(BOOL)doorsOpen_ {
    [self setDoorsOpen:doorsOpen_ animated:NO];
}

- (void)setDoorsOpen:(BOOL)doorsOpen_ animated:(BOOL)animated {
    if (doorsOpen_ == doorsOpen)
        return;
    
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    
    if (animated) {
        [leftDoor stopAllActions];
        [rightDoor stopAllActions];
        if (doorsOpen_) {
            [leftDoor runAction:[CCEaseSineInOut actionWithAction:[CCMoveTo actionWithDuration:0.8f position:ccp(00.0f, 0.0f)]]];
            [rightDoor runAction:[CCEaseSineInOut actionWithAction:[CCMoveTo actionWithDuration:0.8f position:ccp(windowSize.width, 0.0f)]]];
        } else {
            [leftDoor runAction:[CCEaseSineInOut actionWithAction:[CCMoveTo actionWithDuration:0.8f position:ccp(windowSize.width/2.0f, 0.0f)]]];
            [rightDoor runAction:[CCEaseSineInOut actionWithAction:[CCMoveTo actionWithDuration:0.8f position:ccp(windowSize.width/2.0f, 0.0f)]]];
        }
    } else {
        if (doorsOpen_) {
            leftDoor.position = ccp(0.0f, 0.0f);
            rightDoor.position = ccp(windowSize.width, 0.0f);
        } else {
            leftDoor.position = ccp(windowSize.width/2.0f, 0.0f);
            rightDoor.position = ccp(windowSize.width/2.0f, 0.0f);
        }
    }
    
    doorsOpen = doorsOpen_;
}

- (void)dealloc {
    [self removeChild:leftDoor cleanup:YES];
    [leftDoor release];
    [self removeChild:rightDoor cleanup:YES];
    [rightDoor release];
    [super dealloc];
}

@end
