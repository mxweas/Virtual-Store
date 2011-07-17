//
//  Product.h
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : NSObject {
    UIImage *productImage;
    NSString *nameString;
    UIImage *productName;
    NSString *price;
    NSDictionary *productInfo;
}

@property (nonatomic, retain) UIImage *productImage;
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, retain) UIImage *productName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, retain) NSDictionary *productInfo;

@end
