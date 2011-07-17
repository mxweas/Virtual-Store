//
//  RetailigenceRequest.m
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RetailigenceRequest.h"
#import "NSDictionary_JSONExtensions.h"

NSString *const RRProductRequestErrorDomain = @"RRProductRequestErrorDomain";

@implementation RetailigenceRequest

- (NSDictionary *)searchQuery:(NSString *)query maxResults:(int)maxResults error:(NSError **)error {
    NSMutableURLRequest *searchRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.retailigence.com/v1.2/products?format=json&wsvkey=uByva4R46fISjKXTKNhkwwF8VhjsrziC&keywords=%@&latitude=37.47&longitude=-122.26&pagesize=%i", [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], MAX(maxResults, 1)]]];
    [searchRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [searchRequest setTimeoutInterval:40];
    NSData *searchRequestData = [[NSURLConnection sendSynchronousRequest:searchRequest returningResponse:nil error:nil] retain];
    [searchRequest release];
    
    if (searchRequestData != nil) {
        NSDictionary *data = [NSDictionary dictionaryWithJSONData:searchRequestData error:error];
        [searchRequestData release];
        return data;
    } else {
        if (error)
			*error = [NSError errorWithDomain:RRProductRequestErrorDomain code:1 userInfo:[NSDictionary dictionaryWithObject:@"Failed to retrieve products" forKey:NSLocalizedDescriptionKey]];
    }
    
    return nil;
}

@end
