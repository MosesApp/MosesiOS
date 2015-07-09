//
//  PaymentTableViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-07-08.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "PaymentTableViewController.h"
#import "PaymentTableCell.h"
#import "Bill.h"
#import "MGSwipeButton.h"

@interface PaymentTableViewController ()

@end

@implementation PaymentTableViewController
{
    NSArray *bills;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show logo at the top of table view
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    
    // Define line separator properties
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    // Hide search bar at table load
    self.tableView.contentOffset = CGPointMake(0,  self.searchDisplayController.searchBar.frame.size.height - self.tableView.contentOffset.y);

    self.searchDisplayController.searchBar.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Get bill for current group
    bills  = [Bill getBillsForGroupId:1];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([bills count] > 0) {
        
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No bills are associated to this group!";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [bills count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"PaymentTableCell";
    
    PaymentTableCell *cell = (PaymentTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PaymentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
        cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                            cell.contentView.frame.origin.y,
                                            self.tableView.frame.size.width,
                                            self.tableView.frame.size.height * 0.11);
        
        [cell initFields];
    }
    
    // Filter by search bar input
    Bill* bill = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        bill = [searchResults objectAtIndex:indexPath.row];
    } else {
        bill = [bills objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = bill.name;

    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:bill.date
                                                         dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterFullStyle];
    
    if([bill.relation isEqualToString:@"taker"]){
        cell.valueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", bill.amount];
        cell.valueLabel.textColor = [UIColor colorWithRed:65.0/255.0 green:148.0/255.0 blue:56.0/255.0 alpha:1.0f];
        float valueLabelX = cell.thumbnailStatusImageView.frame.origin.x-[cell.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:cell.valueLabel.font}].width - cell.thumbnailStatusImageView.frame.size.width/2;
        cell.valueLabel.frame = CGRectMake(valueLabelX, cell.valueLabel.frame.origin.y, cell.valueLabel.bounds.size.width, cell.valueLabel.bounds.size.height);
        cell.thumbnailStatusImageView.image = [UIImage imageNamed:@"green.png"];
        
    }else if([bill.relation isEqualToString:@"debtor"]){
        cell.valueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", bill.amount];
        cell.valueLabel.textColor = [UIColor colorWithRed:198.0/255.0 green:31.0/255.0 blue:75.0/255.0 alpha:1.0f];
        float valueLabelX = cell.thumbnailStatusImageView.frame.origin.x-[cell.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:cell.valueLabel.font}].width - cell.thumbnailStatusImageView.frame.size.width/2;;
        cell.valueLabel.frame = CGRectMake(valueLabelX, cell.valueLabel.frame.origin.y, cell.valueLabel.bounds.size.width, cell.valueLabel.bounds.size.height);
        cell.thumbnailStatusImageView.image = [UIImage imageNamed:@"red.png"];
    }
    
    cell.nameLabel.frame = CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.valueLabel.frame.origin.x - cell.nameLabel.frame.origin.x,cell.nameLabel.frame.size.height);
    
    cell.dateLabel.frame = CGRectMake(cell.dateLabel.frame.origin.x, cell.dateLabel.frame.origin.y, cell.valueLabel.frame.origin.x - cell.dateLabel.frame.origin.x,cell.dateLabel.frame.size.height);
    
    cell.thumbnailStatusImageView.layer.cornerRadius = cell.thumbnailStatusImageView.frame.size.width / 2;
    cell.thumbnailStatusImageView.clipsToBounds = YES;
    
    if(bill.receiptImage){
        cell.thumbnailBillImageView.image = bill.receiptImage;
    }else{
        cell.thumbnailBillImageView.image = [UIImage imageNamed:@"bill_standard.jpg"];
    }
    cell.thumbnailBillImageView.layer.cornerRadius = cell.thumbnailBillImageView.frame.size.width / 2;
    cell.thumbnailBillImageView.clipsToBounds = YES;
    
    //configure left buttons
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]],
                         [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"fav.png"] backgroundColor:[UIColor blueColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.height * 0.11;
}

// Search bar methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [bills filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    bills = nil;
    searchResults = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
