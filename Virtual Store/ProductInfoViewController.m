//
//  ProductInfoViewController.m
//  Virtual Store
//
//  Created by Max Weisel on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductInfoViewController.h"
#import <MapKit/MapKit.h>
#import "cocos2d.h"

@interface Annotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end

@implementation Annotation

@synthesize coordinate;
@synthesize title;

@end

@implementation ProductInfoViewController

- (id)initWithProduct:(Product *)product_ {
    if ((self = [super init]) != nil) {
        product = [product_ retain];
        self.title = product.nameString;
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)] autorelease];
    }
    return self;
}

- (void)dismiss {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40.0f, 30.0f, 240.0f, 280.0f)];
    imageView.image = product.productImage;
    [self.view addSubview:imageView];
    [imageView release];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(320.0f, 30.0f, 200.0f, 40.0f)];
    price.backgroundColor = [UIColor clearColor];
    price.text = product.price;
    price.font = [UIFont systemFontOfSize:40.0f];
    [self.view addSubview:price];
    [price release];
    
    UILabel *msrp = [[UILabel alloc] initWithFrame:CGRectMake(320.0f, 70.0f, 200.0f, 24.0f)];
    msrp.backgroundColor = [UIColor clearColor];
    msrp.text = [NSString stringWithFormat: @"MSRP: $%@", [[product.productInfo objectForKey:@"product"] objectForKey:@"msrp"]];
    NSLog(@"%@", product.productInfo);
    msrp.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:msrp];
    [msrp release];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(320.0f, 94.0f, 400.0f, 150.0f)];
    description.backgroundColor = [UIColor clearColor];
    description.baselineAdjustment = UIBaselineAdjustmentNone;
    description.lineBreakMode = UILineBreakModeWordWrap;
    description.numberOfLines = 0;
    description.text = [[product.productInfo objectForKey:@"product"] objectForKey:@"descriptionLong"];
    [self.view addSubview:description];
    [description release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(320.0f, 260.0f, 150.0f, 44.0f);
    [button setTitle:@"Product Page" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(productPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(480.0f, 260.0f, 150.0f, 44.0f);
    [button setTitle:@"Buy Now" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    NSDictionary *location = [product.productInfo objectForKey:@"location"];
    
    UILabel *storeName = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 355.0f, 240.0f, 40.0f)];
    storeName.backgroundColor = [UIColor clearColor];
    storeName.lineBreakMode = UILineBreakModeWordWrap;
    storeName.numberOfLines = 2;
    storeName.text = [location objectForKey:@"name"];
    [self.view addSubview:storeName];
    [storeName release];
    
    NSDictionary *address = [location objectForKey:@"address"];
    
    UILabel *address1 = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 420.0f, 240.0f, 24.0f)];
    address1.backgroundColor = [UIColor clearColor];
    address1.text = [address objectForKey:@"address1"];
    [self.view addSubview:address1];
    [address1 release];
    
    UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 440.0f, 240.0f, 24.0f)];
    city.backgroundColor = [UIColor clearColor];
    city.text = [NSString stringWithFormat:@"%@, %@ %@", [address objectForKey:@"city"], [address objectForKey:@"state"], [address objectForKey:@"postal"]];
    [self.view addSubview:city];
    [city release];
    
    UILabel *storeHours = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 475.0f, 240.0f, 100.0f)];
    storeHours.backgroundColor = [UIColor clearColor];
    storeHours.lineBreakMode = UILineBreakModeWordWrap;
    storeHours.numberOfLines = 5;
    storeHours.text = [location objectForKey:@"hours"];
    [self.view addSubview:storeHours];
    [storeHours release];
    
    NSDictionary *gpsLocation = [location objectForKey:@"location"];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(320.0f, 355.0f, 400.0f, 300.0f)];
    mapView.showsUserLocation = YES;
    mapView.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake([[gpsLocation objectForKey:@"latitude"] doubleValue], [[gpsLocation objectForKey:@"longitude"] doubleValue]), 1000.0f, 1000.0f);
    Annotation *annotation = [[Annotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([[gpsLocation objectForKey:@"latitude"] doubleValue], [[gpsLocation objectForKey:@"longitude"] doubleValue]);
    annotation.title = [[location objectForKey:@"retailer"] objectForKey:@"name"];
    [mapView addAnnotation:annotation];
    [annotation release];
    [self.view addSubview:mapView];
    [mapView release];
}

- (void)productPage {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[product.productInfo objectForKey:@"product"] objectForKey:@"url"]]];
}

- (void)buyNow {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[product.productInfo objectForKey:@"product"] objectForKey:@"buyUrl"]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CCDirector sharedDirector] pause];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[CCDirector sharedDirector] resume];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
    [product release];
    [super dealloc];
}

@end
