//
//  BookViewController.m
//  mobile-technology
//
//  Created by Jan Brinkmann on 3/8/13.
//  Copyright (c) 2013 Jan Brinkmann. All rights reserved.
//

#import "BookViewController.h"

@implementation BookViewController

- (void)setBooks:(NSMutableArray *)books
{
    _books = books;
    
    [self.tableView reloadData];
}

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
    
    self.books = [@[] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadBooks];
}

- (void)loadBooks
{
    [SVProgressHUD show];
    
    BookResource *bookResource = [[BookResource alloc] init];
    [bookResource fetchBooks:^(NSMutableArray *items) {
        self.books = items;
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        
    }];
}

#pragma mark -
#pragma mark TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BookCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.textLabel.text = [book title];
    cell.detailTextLabel.text = [book author];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD show];

    NSUInteger row = [indexPath row];
    Book *book = [self.books objectAtIndex:row];
    
    BookResource *bookResource = [[BookResource alloc] init];
    [bookResource deleteBook:^{
        [self.books removeObjectAtIndex:row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [SVProgressHUD showSuccessWithStatus:@"Buch gelöscht!"];
        
    }failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];

    } book:book];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    self.selectedBook = [self.books objectAtIndex:row];
     
    [self performSegueWithIdentifier:@"EditBook" sender:self];
}

#pragma mark -
#pragma mark row selection segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditBook"]) {
        NewBookViewController *controller = segue.destinationViewController;
        controller.currentBook = self.selectedBook;
    
        self.selectedBook = nil;
    }
}

#pragma mark -
#pragma mark Custom Actions
- (IBAction)refreshTapped:(id)sender
{
    [self loadBooks];
}

- (IBAction)editTapped:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing) {
        [self.editButton setStyle:UIBarButtonItemStyleDone];
    } else {
        [self.editButton setStyle:UIBarButtonItemStyleBordered];
    }
}



@end
