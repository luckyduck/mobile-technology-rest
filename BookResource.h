//
//  BookResource.h
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/6/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "API.h"
#import "Book.h"
#import <Foundation/Foundation.h>

typedef void (^BookSuccessBlock)(NSMutableArray *items);

@interface BookResource : NSObject

- (void)fetchBooks:(BookSuccessBlock)success
           failure:(APIFailureBlock)failure;

- (void)deleteBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)keyvaluePair;

- (void)createBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)keyvaluePair;

- (void)updateBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)keyvaluePair;

- (void)parseErrorMessage:(APIFailureBlock)failure
                operation:(AFHTTPRequestOperation *)operation
                    error:(NSError *)error;
@end
 