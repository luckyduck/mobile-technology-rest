//
//  API.h
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/6/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "AFNetworking.h"
#import <UIKit/UIKit.h>

#define ApiURL @"http://localhost/phpmagazin-restapi/web/app_dev.php/"

// error block typedef
typedef void (^APIFailureBlock)(NSString *errorMessage);
typedef void (^APISuccessBlock)();

@interface API : AFHTTPClient

+ (API *)sharedInstance;

@end
