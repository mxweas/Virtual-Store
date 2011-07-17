//
//  DoorLight.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    DoorLightGreen,
    DoorLightRed
} DoorLightColor;

@interface DoorLight : CCSprite {
    CCSpriteFrame *onSpriteFrame;
    CCSpriteFrame *offSpriteFrame;
    BOOL isOn;
    BOOL isBlinking;
}

@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) BOOL isBlinking;

- (id)initWithLightColor:(DoorLightColor)lightColor;

@end
