//
//  NewBookViewController.m
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/9/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "NewBookViewController.h"

@interface NewBookViewController ()

@end

@implementation NewBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.currentBook != nil) {
        self.title = @"Buch editieren";
        
        self.titleField.text = self.currentBook.title;
        self.authorField.text = self.currentBook.author;
    }
}

- (IBAction)doneTapped:(id)sender
{
    NSString *title = [self.titleField text];
    NSString *author = [self.authorField text];
    
    if ([title length] < 1 || [author length] < 1) {
        [SVProgressHUD showErrorWithStatus:@"Bitte alle Informationen angeben"];
        return;
    }
    
    if (self.currentBook) {
        self.currentBook.title = title;
        self.currentBook.author = author;
        
        [self updateBook:self.currentBook];
        
    } else {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInt:0], @"id",
                            title, @"title",
                            author, @"author",
                            nil
                            ];
        
        [self createBook:params];
    }
}

- (void)updateBook:(Book *)book
{
    BookResource *bookResource = [[BookResource alloc] init];
    
    [SVProgressHUD show];
    [bookResource updateBook:^{
        [SVProgressHUD showSuccessWithStatus:@"Buch gespeichert!"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        
    } book:book];
}

- (void)createBook:(NSDictionary *)params
{
    Book *newBook = [[Book alloc] initWithAttributes:params];
    BookResource *bookResource = [[BookResource alloc] init];
    
    [SVProgressHUD show];
    [bookResource createBook:^{
        [SVProgressHUD showSuccessWithStatus:@"Buch gespeichert!"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        
    } book:newBook];
}
@end
