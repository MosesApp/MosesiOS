//
//  FBFriendTableViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2015-01-18.
//  Copyright (c) 2015 Moses. All rights reserved.
//

#import "FBFriendTableViewController.h"
#import "FBFriend.h"
#import "FBFriendTableCell.h"

@interface FBFriendTableViewController ()

@end

@implementation FBFriendTableViewController
{
    NSMutableArray *fbFriends;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Show logo at the top of table view
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Hide search bar at table load
    self.tableView.contentOffset = CGPointMake(0,  self.searchDisplayController.searchBar.frame.size.height - self.tableView.contentOffset.y);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Get facebook friends that use the app
    fbFriends = [FBFriend sharedFBFriends];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [fbFriends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"FBFriendTableCell";
    
    FBFriendTableCell *cell = (FBFriendTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FBFriendTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
        cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                            cell.contentView.frame.origin.y,
                                            self.tableView.frame.size.width,
                                            cell.contentView.frame.size.height);
        
        [cell initFields];
    }
    
    // Filter by search bar input
    FBFriend* fbFriend = [fbFriends objectAtIndex:indexPath.row];
    cell.nameLabel.text = fbFriend.fullName;
    
    cell.thumbnailProfileImageView.layer.cornerRadius = cell.thumbnailProfileImageView.frame.size.width / 2;
    cell.thumbnailProfileImageView.clipsToBounds = YES;
    
    cell.thumbnailProfileImageView.image = fbFriend.image;
    cell.thumbnailProfileImageView.layer.cornerRadius = cell.thumbnailProfileImageView.frame.size.width / 2;
    cell.thumbnailProfileImageView.clipsToBounds = YES;
    if(fbFriend.selected){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FBFriendTableCell *cell = (FBFriendTableCell*) [tableView cellForRowAtIndexPath:indexPath];
    FBFriend *fbFriend = [fbFriends objectAtIndex:indexPath.row];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        fbFriend.selected = TRUE;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        fbFriend.selected = FALSE;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [fbFriends replaceObjectAtIndex:indexPath.row withObject:fbFriend];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.height * 0.11;
}

// Search bar methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"fullName contains[c] %@", searchText];
    searchResults = [fbFriends filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)dealloc {
    fbFriends = nil;
    searchResults = nil;
    NSLog(@"dealloc - %@",[self class]);
}

@end
