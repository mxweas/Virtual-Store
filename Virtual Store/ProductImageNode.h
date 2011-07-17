//
//  ProductImageNode.h
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3MeshNode.h"
#import "Product.h"

@interface ProductImageNode : CC3MeshNode {
    Product *product;
}

@property (nonatomic, retain) Product *product;

@end
