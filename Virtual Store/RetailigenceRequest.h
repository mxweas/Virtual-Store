//
//  RetailigenceRequest.h
//  Virtual Store
//
//  Created by Max Weisel on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RetailigenceRequest : NSObject {
    
}

- (NSDictionary *)searchQuery:(NSString *)query maxResults:(int)maxResults error:(NSError **)error;

@end

VS_EXTERN NSString *const RRProductRequestErrorDomain;