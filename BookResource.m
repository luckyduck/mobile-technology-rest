//
//  BookResource.m
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/6/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "BookResource.h"

@implementation BookResource

- (void)fetchBooks:(BookSuccessBlock)success
                   failure:(APIFailureBlock)failure
{
    [[API sharedInstance] getPath:@"books"
                       parameters:nil
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              NSMutableArray *books = [[NSMutableArray alloc] init];
                              
                              for (NSDictionary *attributes in [responseObject valueForKeyPath:@"books"]) {
                                  NSLog(@"%@", attributes);
                                  Book *book = [[Book alloc] initWithAttributes:attributes];
                                  [books addObject:book];
                                  book = nil;
                              }
                                                            
                              success(books);
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              [self parseErrorMessage:failure operation:operation error:error]; 
                          }];
}

- (void)deleteBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)book
{
    NSString *apiPath = [NSString stringWithFormat:@"books/%d", book.bookId];
    [[API sharedInstance] deletePath:apiPath
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success();
                                 
                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 [self parseErrorMessage:failure operation:operation error:error];
                             }];
}

- (void)createBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)book
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%ld", (long)book.bookId ], @"book[id]",
                            book.title, @"book[title]",
                            book.author, @"book[author]",
                            nil];
    
    [[API sharedInstance] postPath:@"books"
                        parameters:params
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               success();
                               
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [self parseErrorMessage:failure operation:operation error:error];
                           }];
}


- (void)updateBook:(APISuccessBlock)success
           failure:(APIFailureBlock)failure
              book:(Book *)book
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%ld", (long)book.bookId ], @"book[id]",
                            book.title, @"book[title]",
                            book.author, @"book[author]",
                            nil];
    
    NSString *requestPath = [NSString stringWithFormat:@"books/%d", book.bookId];
    [[API sharedInstance] putPath:requestPath
                       parameters:params
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              success();
                              
                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              [self parseErrorMessage:failure operation:operation error:error];
                          }];
}

#pragma mark -
#pragma mark error handling

- (void)parseErrorMessage:(APIFailureBlock)failure
                      operation:(AFHTTPRequestOperation *)operation
                          error:(NSError *)error
{
    if ([operation.responseString length] > 0) {
        NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:0
                                                               error:nil];
        failure([json objectForKey:@"message"]);
        
    } else {
        failure([error localizedDescription]);
    }
}

@end
