//
//  BookViewController.h
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/8/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookResource.h"
#import "SVProgressHUD.h"

#import "NewBookViewController.h"

@interface BookViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *books;
@property (strong, nonatomic) Book *selectedBook;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)refreshTapped:(id)sender;
- (IBAction)editTapped:(id)sender;


@end
