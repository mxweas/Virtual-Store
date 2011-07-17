//
//  StoreLayer.m
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoreLayer.h"


@implementation StoreLayer

- (id)init {
    if ((self = [super init]) != nil) {
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
