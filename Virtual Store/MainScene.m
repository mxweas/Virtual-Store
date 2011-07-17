//
//  MainScene.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

@synthesize storeState;

- (id)init {
    if ((self = [super init]) != nil) {
        doorsLayer = [[DoorsLayer alloc] init];
        [self addChild:doorsLayer z:1];
        
        storeState = StoreStateIdle;
    }
    return self;
}

- (void)setStoreState:(StoreState)storeState_ animated:(BOOL)animated {
    if (storeState_ == storeState)
        return;
    
    switch (storeState_) {
        case StoreStateIdle:
            [doorsLayer setDoorsOpen:NO animated:animated];
            doorsLayer.leftDoor.greenLight.isBlinking = NO;
            doorsLayer.leftDoor.redLight.isBlinking = NO;
            doorsLayer.leftDoor.greenLight.isOn = NO;
            doorsLayer.leftDoor.redLight.isOn = NO;
            break;
        case StoreStateSearching:
            [doorsLayer setDoorsOpen:NO animated:animated];
            doorsLayer.leftDoor.greenLight.isOn = YES;
            doorsLayer.leftDoor.redLight.isOn = NO;
            doorsLayer.leftDoor.greenLight.isBlinking = YES;
            doorsLayer.leftDoor.redLight.isBlinking = YES;
            break;
        case StoreStateSuccess:
            [doorsLayer setDoorsOpen:NO animated:animated];
            doorsLayer.leftDoor.redLight.isBlinking = NO;
            doorsLayer.leftDoor.greenLight.isOn = YES;
            doorsLayer.leftDoor.redLight.isOn = NO;
            doorsLayer.leftDoor.greenLight.isBlinking = YES;
            break;
        case StoreStateFail:
            [doorsLayer setDoorsOpen:NO animated:animated];
            doorsLayer.leftDoor.greenLight.isBlinking = NO;
            doorsLayer.leftDoor.redLight.isBlinking = NO;
            doorsLayer.leftDoor.greenLight.isOn = NO;
            doorsLayer.leftDoor.redLight.isOn = YES;
            break;
        case StoreStateOpen:
            [doorsLayer setDoorsOpen:YES animated:animated];
            doorsLayer.leftDoor.greenLight.isBlinking = NO;
            doorsLayer.leftDoor.redLight.isBlinking = NO;
            doorsLayer.leftDoor.greenLight.isOn = YES;
            doorsLayer.leftDoor.redLight.isOn = NO;
            break;
    }
    
    storeState = storeState_;
}

- (void)setStoreState:(StoreState)storeState_ {
    [self setStoreState:storeState_ animated:NO];
}

- (void)setupWorld {
    if (storeLayer != nil) {
        [self removeChild:storeLayer cleanup:YES];
        [storeLayer release];
    }
    if (storeWorld != nil) {
        [storeWorld release];
        
    }
    
    storeWorld = [[StoreWorld alloc] init];
    [storeWorld play];
    
    storeLayer = [[StoreLayer alloc] init];
    storeLayer.cc3World = storeWorld;
    
    [storeLayer scheduleUpdate];
    
    [self addChild:storeLayer z:0];
}

- (void)loadProducts:(NSArray *)products {
    [self setupWorld];
    [storeWorld loadProducts:products];
}

- (void)dealloc {
    [self removeChild:doorsLayer cleanup:YES];
    [doorsLayer release];
    [self removeChild:storeLayer cleanup:YES];
    [storeLayer release];
    [storeWorld release];
    [super dealloc];
}

@end
