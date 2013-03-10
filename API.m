//
//  API.m
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/6/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "API.h"

@implementation API

+ (API*)sharedInstance
{
    static API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:ApiURL]];
    });
    
    [sharedInstance setDefaultHeader:@"Accept" value:@"application/json"];
    
    return sharedInstance;
}
                          
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
            
    return self;
}

@end
