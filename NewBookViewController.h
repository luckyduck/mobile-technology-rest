//
//  NewBookViewController.h
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/9/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookResource.h"
#import "SVProgressHUD.h"

@interface NewBookViewController : UIViewController

@property (strong, nonatomic) Book *currentBook;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;

- (IBAction)doneTapped:(id)sender;

@end
