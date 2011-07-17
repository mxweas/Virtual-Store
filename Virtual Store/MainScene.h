//
//  MainScene.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DoorsLayer.h"
#import "StoreWorld.h"
#import "StoreLayer.h"

typedef enum {
    StoreStateIdle = 0,
    StoreStateSearching,
    StoreStateSuccess,
    StoreStateFail,
    StoreStateOpen
} StoreState;

@interface MainScene : CCScene {
    StoreWorld *storeWorld;
    StoreLayer *storeLayer;
    DoorsLayer *doorsLayer;
    StoreState storeState;
}

@property (nonatomic, assign) StoreState storeState;

- (void)setStoreState:(StoreState)storeState animated:(BOOL)animated;
- (void)loadProducts:(NSArray *)products;

@end
