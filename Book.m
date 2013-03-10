//
//  Book.m
//  mobile-technology
//
//  Created by Jan Brinkmann
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id)initWithAttributes:(NSDictionary *)attributes
{
    NSLog(@"%@",attributes);
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.bookId = [[attributes valueForKeyPath:@"id"] intValue];
    self.title = [attributes valueForKeyPath:@"title"];
    self.author = [attributes valueForKeyPath:@"author"];
    
    return self;
}

@end
