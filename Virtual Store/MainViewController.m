//
//  MainViewController.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "cocos2d.h"
#import "MainScene.h"
#import "RetailigenceRequest.h"
#import "Product.h"
#import "ProductInfoViewController.h"

static MainViewController *sharedInstance = nil;

@implementation MainViewController

+ (id)sharedInstance {
    return sharedInstance;
}

- (id)init {
    if ((self = [super init]) != nil) {
        if (![CCDirector setDirectorType:kCCDirectorTypeDisplayLink])
            [CCDirector setDirectorType:kCCDirectorTypeDefault];
                
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        searchBar.delegate = self;
        self.navigationItem.titleView = searchBar;
        [searchBar release];
                
        if (sharedInstance == nil)
            sharedInstance = self;
    }
    return self;
}

- (void)finishQueryWithData:(NSArray *)products {
    [mainScene loadProducts:products];
    [mainScene setStoreState:StoreStateOpen animated:YES];
}

- (void)failWithError:(NSError *)error {
    [error retain];
    mainScene.storeState = StoreStateFail;
    NSString *errorMessage = (error) ? [error localizedDescription] : @"Something went wrong :(";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Virtual Store" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    [error release];
}

- (void)setSuccess {
    mainScene.storeState = StoreStateSuccess;
}

- (void)generateImageForText:(NSMutableDictionary *)textDict {
    UIGraphicsBeginImageContext(CGSizeMake(200.0f, 44.0f));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, 200.0f, 64.0f));
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [[textDict objectForKey:@"text"] drawInRect:CGRectMake(4.0f, 4.0f, 180.0f, 32.0f) withFont:[UIFont systemFontOfSize:14.0f] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    [textDict setObject:UIGraphicsGetImageFromCurrentImageContext() forKey:@"image"];
    UIGraphicsEndImageContext();
}

- (void)searchWithQuery:(NSString *)query {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [query retain];
    RetailigenceRequest *request = [[RetailigenceRequest alloc] init];
    NSError *error = nil;
    NSDictionary *data = [request searchQuery:query maxResults:70 error:&error];
    if (data != nil) {
        [self performSelectorOnMainThread:@selector(setSuccess) withObject:nil waitUntilDone:YES];
        NSArray *results = [[data objectForKey:@"RetailigenceSearchResult"] objectForKey:@"results"];
        if (results != nil && ![results isKindOfClass:[NSNull class]]) {
            NSMutableArray *products = [[NSMutableArray alloc] initWithCapacity:results.count];
            for (NSDictionary *result in results) {
                NSLog(@"New Product");
                NSDictionary *resultDict = [result objectForKey:@"SearchResult"];
                NSDictionary *productDict = [resultDict objectForKey:@"product"];
                NSArray *images = [productDict objectForKey:@"images"];
                NSString *imageURLString = @"http://catalog.surplusequipment-stl.com/templates/template2/images/no_product_image.jpg";
                if ([images isKindOfClass:[NSArray class]])
                    imageURLString = [[[images objectAtIndex:0] objectForKey:@"ImageInfo"] objectForKey:@"link"];
                Product *product = [[Product alloc] init];
                product.productImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]];
                if ([productDict isKindOfClass:[NSDictionary class]] && [productDict objectForKey:@"name"] != nil && ![[productDict objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
                    NSMutableDictionary *textDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[productDict objectForKey:@"name"], @"text", nil];
                    [self performSelectorOnMainThread:@selector(generateImageForText:) withObject:textDict waitUntilDone:YES];
                    product.productName = [textDict objectForKey:@"image"];
                    product.nameString = [productDict objectForKey:@"name"];
                    [textDict release];
                }
                if ([[resultDict objectForKey:@"price"] isKindOfClass:[NSDecimalNumber class]])
                    product.price = [NSString stringWithFormat:@"$%@",[resultDict objectForKey:@"price"]];
                else
                    product.price = @"N/A";
                product.productInfo = resultDict;
                [products addObject:product];
                [product release];
            }
            [self performSelectorOnMainThread:@selector(finishQueryWithData:) withObject:[products autorelease] waitUntilDone:YES];
        } else {
            [self performSelectorOnMainThread:@selector(failWithError:) withObject:nil waitUntilDone:YES];
        }
    }
    else
        [self performSelectorOnMainThread:@selector(failWithError:) withObject:error waitUntilDone:YES];
    [query release];
    [pool release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    mainScene.storeState = StoreStateSearching;
    [NSThread detachNewThreadSelector:@selector(searchWithQuery:) toTarget:self withObject:[[searchBar.text copy] autorelease]];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [mainScene setStoreState:StoreStateIdle animated:YES];
}

- (void)displayInfoForProduct:(Product *)product {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[[ProductInfoViewController alloc] initWithProduct:product] autorelease]];
    navigationController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CCDirector *director = [CCDirector sharedDirector];
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.height, frame.size.width);
    frame.size.height -= 44.0f; // Navigation Bar
    EAGLView *eaglView = [EAGLView viewWithFrame:frame pixelFormat:kEAGLColorFormatRGBA8 depthFormat:GL_DEPTH_COMPONENT16_OES];
    eaglView.autoresizingMask = self.view.autoresizingMask;
    [director setOpenGLView:eaglView];
    [director setAnimationInterval:1/60.0f];
    [director setDisplayFPS:YES];
    self.view = eaglView;
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    if (mainScene == nil)
        mainScene = [[MainScene alloc] init];
    
    [[CCDirector sharedDirector] runWithScene:mainScene];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
    [mainScene release];
    if (sharedInstance == self)
        sharedInstance = nil;
    [super dealloc];
}

@end
