//
//  DoorLight.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DoorLight.h"

@interface DoorLightBlinkAction : CCActionInterval {
    BOOL reverse;
}
@end

@implementation DoorLightBlinkAction

- (void)startWithTarget:(id)target {
    reverse = ((DoorLight *)target).isOn;
    [super startWithTarget:target];
}

- (void)update:(ccTime)dt {
    ((DoorLight *)target_).isOn = reverse ? (dt < 0.5f) : (dt > 0.5f);
}

@end

@implementation DoorLight

@synthesize isOn;
@synthesize isBlinking;

- (id)initWithLightColor:(DoorLightColor)lightColor {
    if ((self = [super init]) != nil) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"DoorLights.plist"];
        switch (lightColor) {
            case DoorLightGreen:
                onSpriteFrame = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GreenLightOn.png"] retain];
                offSpriteFrame = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GreenLightOff.png"] retain];
                break;
            case DoorLightRed:
                onSpriteFrame = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"RedLightOn.png"] retain];
                offSpriteFrame = [[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"RedLightOff.png"] retain];
                break;
            default:
                onSpriteFrame = offSpriteFrame = nil;
                break;
        }
        [self setDisplayFrame:offSpriteFrame];
        isOn = NO;
        isBlinking = NO;
    }
    return self;
}

- (void)setIsOn:(BOOL)isOn_ {
    if (isOn_ == isOn)
        return;
        
    [self setDisplayFrame:(isOn_) ? onSpriteFrame : offSpriteFrame];
    
    isOn = isOn_;
}

- (void)setIsBlinking:(BOOL)isBlinking_ {
    if (isBlinking_ == isBlinking)
        return;

    [self stopAllActions];
    if (isBlinking_)
        [self runAction:[CCRepeatForever actionWithAction:[DoorLightBlinkAction actionWithDuration:0.4f]]];
    
    isBlinking = isBlinking_;
}

- (void)dealloc {
    [onSpriteFrame release];
    [offSpriteFrame release];
    [super dealloc];
}

@end
