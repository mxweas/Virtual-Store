//
//  MainViewController.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainScene.h"
#import "Product.h"

@interface MainViewController : UIViewController <UISearchBarDelegate> {
    MainScene *mainScene;
}

+ (id)sharedInstance;
- (void)displayInfoForProduct:(Product *)product;

@end
