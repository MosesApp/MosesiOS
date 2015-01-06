//
//  RecipeTableViewController.m
//  NavigationBarDemo
//
//  Created by Simon on 2/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "TalksTableViewController.h"
#import "TalksTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TalksTableViewController ()

@end

@implementation TalksTableViewController
{
    NSArray *messages;
    NSArray *thumbnails;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    messages = [NSArray arrayWithObjects:@"Daniel", @"Pedro", @"Jorge", nil];
    thumbnails = [NSArray arrayWithObjects:@"creme_brelee.jpg", @"mushroom_risotto.jpg", @"full_breakfast.jpg", nil];
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(self.tableView.frame.size.height * 0.15, self.tableView.frame.size.width * 0.20, 1, 1);
    
    // Hide search bar at table load
    self.tableView.contentOffset = CGPointMake(0,  self.searchDisplayController.searchBar.frame.size.height - self.tableView.contentOffset.y);
    
    // This will remove extra separators from tableview
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [messages count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TalksCell";

    // Similar to UITableViewCell, but
    TalksTableViewCell *cell = (TalksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TalksTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    BOOL isInPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    
    if(!isInPortrait){
        
    }
    
    
    // Filter by search bar input
    NSString* message = nil;
    NSString* thumbnail = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        message = [searchResults objectAtIndex:indexPath.row];
        NSUInteger indexOfTheObject = [messages indexOfObject: message];
        thumbnail = [thumbnails objectAtIndex:indexOfTheObject];
    } else {
        message = [messages objectAtIndex:indexPath.row];
        thumbnail = [thumbnails objectAtIndex:indexPath.row];
    }
    
    //cell.nameLabel.frame.origin.x;
    
    cell.nameLabel.text = message;
    cell.messageLabel.text = @"Test message text";
    cell.timeLabel.text = @"11:25";
    
    cell.thumbnailImageView.image = [UIImage imageNamed:thumbnail];
    cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2;
    cell.thumbnailImageView.clipsToBounds = YES;
    
    cell.userStatusImageView.image = [UIImage imageNamed:@"status_icon.png"];
    cell.userStatusImageView.layer.cornerRadius = cell.userStatusImageView.frame.size.width / 2;
    cell.userStatusImageView.clipsToBounds = YES;
    
    cell.messageViewedImageView.image = [UIImage imageNamed:@"check_icon.png"];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isInPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    
    float frameHeight = 0.0;
    // Each cell takes 15% of the screen
    if (isInPortrait) {
        frameHeight = self.tableView.frame.size.height * 0.13;
    // Each cell takes 25% of the screen
    }else{
        frameHeight = self.tableView.frame.size.height * 0.25;
    }

    return frameHeight;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView reloadData];
}

// Search bar methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    searchResults = [messages filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

@end
