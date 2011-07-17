//
//  ProductInfoViewController.h
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductInfoViewController : UIViewController {
    Product *product;
}

- (id)initWithProduct:(Product *)product;

@end
