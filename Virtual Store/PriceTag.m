//
//  PriceTag.m
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PriceTag.h"


@implementation PriceTag

- (id)initWithPrice:(NSString *)price_ {
    if ((self = [super initWithFile:@"PriceTag.png"]) != nil) {
        price = [price_ retain];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:price fontName:@"Helvetica-Bold" fontSize:30.0f];
        label.position = ccp(self.contentSize.width/2.0f, self.contentSize.height/2.0f);
        [self addChild:label];
    }
    return self;
}

- (void)dealloc {
    [price release];
    [super dealloc];
}

@end
