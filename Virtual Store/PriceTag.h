//
//  PriceTag.h
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PriceTag : CCSprite {
    NSString *price;
}

- (id)initWithPrice:(NSString *)price;

@end
