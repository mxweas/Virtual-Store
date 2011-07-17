//
//  StoreWorld.m
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoreWorld.h"
#import "CC3Math.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "Product.h"
#import "CC3Billboard.h"
#import "PriceTag.h"
#import "ProductImageNode.h"
#import "MainViewController.h"

@implementation StoreWorld

- (id)init {
    if ((self = [super init]) != nil) {
        camera = [[CC3Camera alloc] initWithName:@"Camera"];
        camera.location = cc3v(0.0f, 0.0f, 6.0f);
        [self addChild:camera];
        
        self.ambientLight = kCCC4FBlackTransparent;
        
        motionManager = [[CMMotionManager alloc] init];
        motionManager.deviceMotionUpdateInterval = 1/60.0f;
        [motionManager startDeviceMotionUpdates];
        
        leftWall = [[CC3MeshNode alloc] init];
        [leftWall populateAsCenteredRectangleWithSize:CGSizeMake(80.0f, 5.0f) withTexture:[CC3Texture textureFromFile:@"WoodTexture.png"] invertTexture:NO];
        leftWall.location = cc3v(-4.0f, 0.0f, -20.0f);
        leftWall.rotation = cc3v(0.0f, 90.0f, 0.0f);
        [self addChild:leftWall];
        
        rightWall = [[CC3MeshNode alloc] init];
        [rightWall populateAsCenteredRectangleWithSize:CGSizeMake(80.0f, 5.0f) withTexture:[CC3Texture textureFromFile:@"WoodTexture.png"] invertTexture:NO];
        rightWall.location = cc3v(4.0f, 0.0f, -20.0f);
        rightWall.rotation = cc3v(0.0f, -90.0f, 0.0f);
        [self addChild:rightWall];
        
        CC3MeshNode *floor = [[CC3MeshNode alloc] init];
        [floor populateAsCenteredRectangleWithSize:CGSizeMake(80.0f, 8.0f) withTexture:[CC3Texture textureFromFile:@"FloorTexture.png"] invertTexture:NO];
        floor.location = cc3v(0.0f, -2.5f, -20.0f);
        floor.rotation = cc3v(-90.0f, -90.0f, 0.0f);
        [self addChild:floor];
        [floor release];
        
        CC3MeshNode *ceiling = [[CC3MeshNode alloc] init];
        [ceiling populateAsCenteredRectangleWithSize:CGSizeMake(80.0f, 8.0f) withTexture:[CC3Texture textureFromFile:@"CeilingTexture.png"] invertTexture:NO];
        ceiling.location = cc3v(0.0f, 2.5f, -20.0f);
        ceiling.rotation = cc3v(90.0f, -90.0f, 0.0f);
        [self addChild:ceiling];
        [ceiling release];
        
        CC3MeshNode *steve = [[CC3MeshNode alloc] init];
        [steve populateAsCenteredRectangleWithSize:CGSizeMake(8.0f, 5.0f) withTexture:[CC3Texture textureFromFile:@"Steve.png"] invertTexture:YES];
        steve.location = cc3v(0.0f, 0.0f, -60.0f);
        [self addChild:steve];
        [steve release];
        
        CC3MeshNode *exit = [[CC3MeshNode alloc] init];
        [exit populateAsCenteredRectangleWithSize:CGSizeMake(8.0f, 5.0f) withTexture:[CC3Texture textureFromFile:@"ExitTexture.png"] invertTexture:YES];
        exit.location = cc3v(0.0f, 0.0f, 20.0f);
        exit.rotation = cc3v(0.0f, 180.0f, 0.0f);
        [self addChild:exit];
        [exit release];
    }
    return self;
}

- (void)update:(ccTime)dt {
    if (motionManager.deviceMotion != nil) {
        CMAttitude *attitude = motionManager.deviceMotion.attitude;
        camera.rotation = cc3v(0.0f, RadiansToDegrees(attitude.yaw), -1.0f*RadiansToDegrees(attitude.pitch));
        CMAcceleration gravity = motionManager.deviceMotion.gravity;
        float direction = 0.8f - fabsf(gravity.x);
        CC3Vector camLocation = camera.location;
        camLocation.z += 0.4f*direction*camera.forwardDirection.z;
        camLocation.z = MIN(MAX(-53.0f, camLocation.z), 12.0f);
        camera.location = camLocation;
    }
}

- (void)loadProducts:(NSArray *)products {
    [products retain];
    int i = 0;
    int productCount = products.count;
    for (; i < productCount/2; i++) {
        CC3MeshNode *productName = [[CC3MeshNode alloc] init];
        CC3Texture *textureName = [[CC3Texture alloc] init];
        textureName.texture = [[[CCTexture2D alloc] initWithImage:((Product *)[products objectAtIndex:i]).productName] autorelease];
        [productName populateAsCenteredRectangleWithSize:CGSizeMake(2.0f, 0.25f) withTexture:textureName invertTexture:YES];
        [textureName release];
        productName.location = cc3v(i*2.2f-(productCount/2)*2.2f*0.5f, 1.14f, 1.0f);
        [leftWall addChild:productName];
        [productName release];
        
        ProductImageNode *productNode = [[ProductImageNode alloc] init];
        productNode.product = [products objectAtIndex:i];
        productNode.isTouchEnabled = YES;
        CC3Texture *texture = [[CC3Texture alloc] init];
        texture.texture = [[[CCTexture2D alloc] initWithImage:((Product *)[products objectAtIndex:i]).productImage] autorelease];
        [productNode populateAsCenteredRectangleWithSize:CGSizeMake(2.0f, 2.0f) withTexture:texture invertTexture:YES];
        [texture release];
        productNode.location = cc3v(i*2.2f-(productCount/2)*2.2f*0.5f, 0.0f, 1.0f);
        CC3Billboard *billboard = [[CC3Billboard alloc] initWithBillboard:[[[PriceTag alloc] initWithPrice:((Product *)[products objectAtIndex:i]).price] autorelease]];
        billboard.location = cc3v(-0.9f, 0.9f, 0.0f);
        billboard.unityScaleDistance = 2.5f;
        billboard.minimumBillboardScale = ccp(0.0f, 0.0f);
        [productNode addChild:billboard];
        [billboard release];
        [leftWall addChild:productNode];
        [productNode release];
    }
    for (; i < productCount; i++) {
        CC3MeshNode *productName = [[CC3MeshNode alloc] init];
        CC3Texture *textureName = [[CC3Texture alloc] init];
        textureName.texture = [[[CCTexture2D alloc] initWithImage:((Product *)[products objectAtIndex:i]).productName] autorelease];
        [productName populateAsCenteredRectangleWithSize:CGSizeMake(2.0f, 0.25f) withTexture:textureName invertTexture:YES];
        [textureName release];
        productName.location = cc3v((i-productCount/2)*2.2f-(productCount - productCount/2)*2.2f*0.5f, 1.14f, 1.0f);
        [rightWall addChild:productName];
        [productName release];
        
        ProductImageNode *productNode = [[ProductImageNode alloc] init];
        productNode.product = [products objectAtIndex:i];
        productNode.isTouchEnabled = YES;
        CC3Texture *texture = [[CC3Texture alloc] init];
        texture.texture = [[CCTexture2D alloc] initWithImage:((Product *)[products objectAtIndex:i]).productImage];
        [productNode populateAsCenteredRectangleWithSize:CGSizeMake(2.0f, 2.0f) withTexture:texture invertTexture:YES];
        [texture release];
        productNode.location = cc3v((i-productCount/2)*2.2f-(productCount - productCount/2)*2.2f*0.5f, 0.0f, 1.0f);
        CC3Billboard *billboard = [[CC3Billboard alloc] initWithBillboard:[[[PriceTag alloc] initWithPrice:((Product *)[products objectAtIndex:i]).price] autorelease]];
        billboard.location = cc3v(0.9f, 0.9f, 0.0f);
        billboard.unityScaleDistance = 2.5f;
        billboard.minimumBillboardScale = ccp(0.0f, 0.0f);
        [productNode addChild:billboard];
        [billboard release];
        [rightWall addChild:productNode];
        [productNode release];
    }
    [products release];
}

- (void)nodeSelected:(CC3Node*)aNode byTouchEvent:(uint)touchType at:(CGPoint)touchPoint {
    if (touchType == kCCTouchEnded && [aNode isKindOfClass:[ProductImageNode class]]) {
        [[MainViewController sharedInstance] displayInfoForProduct:((ProductImageNode *)aNode).product];
    }
}

- (void)dealloc {
    [self removeChild:camera];
    [camera release];
    [super dealloc];
}

@end
