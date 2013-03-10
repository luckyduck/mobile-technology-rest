//
//  Book.h
//  mobile-technology
//
//  Created by Jan Brinkmann
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property NSInteger bookId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;

- (id)initWithAttributes:(NSDictionary *)attributes;


@end
