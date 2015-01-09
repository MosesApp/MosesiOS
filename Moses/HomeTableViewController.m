//
//  HomeTableViewController.m
//  Moses
//
//  Created by Daniel Marchena on 2014-12-14.
//  Copyright (c) 2014 Moses. All rights reserved.
//

#import "HomeTableViewController.h"
#import "HomeTableCell.h"
#import "Group.h"
#import "Bill.h"
#import "User.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HomeTableViewController ()
@end

@implementation HomeTableViewController
{
    NSArray *groups;
    NSArray *bills;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    groups = [Group sharedUserGroups];
    bills  = [Bill sharedBills];
    
    // Show logo at the top of table view
    self.parentViewController.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    
    // Change navigation bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.translucent = YES;
    
    // Define line separator properties
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    // Hide search bar at table load
    self.tableView.contentOffset = CGPointMake(0,  self.searchDisplayController.searchBar.frame.size.height - self.tableView.contentOffset.y);
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSMutableDictionary* financialSituation = [Bill getFinancialSituation];
    
    UIView *sectionHeaderView = [[UIView alloc] init];

    sectionHeaderView.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height * 0.15);
    sectionHeaderView.layer.borderColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1].CGColor;
    sectionHeaderView.layer.borderWidth = 0.5;
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1];
    
    // You owe
    UILabel *youOweLabel = [[UILabel alloc] init];
    [youOweLabel setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    youOweLabel.text = @"you owe";
    youOweLabel.textColor = [UIColor lightGrayColor];
    
    CGSize textSizeYouOweLabel = [[youOweLabel text] sizeWithAttributes:@{NSFontAttributeName:[youOweLabel font]}];
    youOweLabel.frame = CGRectMake((sectionHeaderView.frame.size.width/3 - textSizeYouOweLabel.width)/2, sectionHeaderView.frame.size.height * 0.15,textSizeYouOweLabel.width,textSizeYouOweLabel.height);
    [sectionHeaderView addSubview:youOweLabel];
    
    // Value
    UILabel *youOweValueLabel = [[UILabel alloc] init];
    [youOweValueLabel setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    
    float owe = [financialSituation[@"owe"] floatValue];
    youOweValueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"-$", owe];
    youOweValueLabel.textColor = [UIColor colorWithRed:198.0/255.0 green:31.0/255.0 blue:75.0/255.0 alpha:1.0f];
    
    CGSize textSizeYouOweValueLabel = [[youOweValueLabel text] sizeWithAttributes:@{NSFontAttributeName:[youOweValueLabel font]}];
    youOweValueLabel.frame = CGRectMake((sectionHeaderView.frame.size.width/3 - textSizeYouOweValueLabel.width)/2, sectionHeaderView.frame.size.height * 0.55,textSizeYouOweValueLabel.width,textSizeYouOweValueLabel.height);
    [sectionHeaderView addSubview:youOweValueLabel];
    
    // You are owed
    UILabel *youAreOwedLabel = [[UILabel alloc] init];
    [youAreOwedLabel setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    youAreOwedLabel.text = @"you are owed";
    youAreOwedLabel.textColor = [UIColor lightGrayColor];
    
    CGSize textSizeYouAreOwedLabel = [[youAreOwedLabel text] sizeWithAttributes:@{NSFontAttributeName:[youAreOwedLabel font]}];
    youAreOwedLabel.frame = CGRectMake(sectionHeaderView.frame.size.width/6 + (sectionHeaderView.frame.size.width/1.5 - textSizeYouAreOwedLabel.width)/2, sectionHeaderView.frame.size.height * 0.15,textSizeYouAreOwedLabel.width,textSizeYouAreOwedLabel.height);
    [sectionHeaderView addSubview:youAreOwedLabel];
    
    // Value
    UILabel *youAreOwedValueLabel = [[UILabel alloc] init];
    [youAreOwedValueLabel setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    
    float owed = [financialSituation[@"owed"] floatValue];
    youAreOwedValueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", owed];
    youAreOwedValueLabel.textColor = [UIColor colorWithRed:65.0/255.0 green:148.0/255.0 blue:56.0/255.0 alpha:1.0f];
    
    CGSize textSizeYouAreOwedValueLabel = [[youAreOwedValueLabel text] sizeWithAttributes:@{NSFontAttributeName:[youAreOwedValueLabel font]}];
    youAreOwedValueLabel.frame = CGRectMake(sectionHeaderView.frame.size.width/6 + (sectionHeaderView.frame.size.width/1.5 - textSizeYouAreOwedValueLabel.width)/2, sectionHeaderView.frame.size.height * 0.55,textSizeYouAreOwedValueLabel.width,textSizeYouAreOwedValueLabel.height);
    [sectionHeaderView addSubview:youAreOwedValueLabel];
    
    
    // Total balance
    UILabel *totalBalanceLabel = [[UILabel alloc] init];
    [totalBalanceLabel setFont:[UIFont fontWithName:@"Arial" size:15.0]];
    totalBalanceLabel.text = @"total balance";
    totalBalanceLabel.textColor = [UIColor lightGrayColor];
    
    CGSize textSizeTotalBalanceLabel = [[totalBalanceLabel text] sizeWithAttributes:@{NSFontAttributeName:[totalBalanceLabel font]}];
    totalBalanceLabel.frame = CGRectMake(sectionHeaderView.frame.size.width/1.5 + (sectionHeaderView.frame.size.width - sectionHeaderView.frame.size.width/1.5 - textSizeTotalBalanceLabel.width)/2, sectionHeaderView.frame.size.height * 0.15,textSizeTotalBalanceLabel.width,textSizeTotalBalanceLabel.height);
    [sectionHeaderView addSubview:totalBalanceLabel];
    
    // Value
    UILabel *totalBalanceValueLabel = [[UILabel alloc] init];
    [totalBalanceValueLabel setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    
    float balance = [financialSituation[@"balance"] floatValue];
    if([financialSituation[@"balance"] floatValue] >= 0.0){
        totalBalanceValueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", balance];
        totalBalanceValueLabel.textColor = [UIColor colorWithRed:65.0/255.0 green:148.0/255.0 blue:56.0/255.0 alpha:1.0f];
    }else{
        balance *= -1;
        totalBalanceValueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"-$", balance];
        totalBalanceValueLabel.textColor = [UIColor colorWithRed:198.0/255.0 green:31.0/255.0 blue:75.0/255.0 alpha:1.0f];
    }
    
    CGSize textSizeTotalBalanceValueLabel = [[totalBalanceValueLabel text] sizeWithAttributes:@{NSFontAttributeName:[totalBalanceValueLabel font]}];
    totalBalanceValueLabel.frame = CGRectMake(sectionHeaderView.frame.size.width/1.5 + (sectionHeaderView.frame.size.width - sectionHeaderView.frame.size.width/1.5 - textSizeTotalBalanceValueLabel.width)/2, sectionHeaderView.frame.size.height * 0.55,textSizeTotalBalanceValueLabel.width,textSizeTotalBalanceValueLabel.height);
    [sectionHeaderView addSubview:totalBalanceValueLabel];
    
    // Separator Lines
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(sectionHeaderView.frame.size.width/3, sectionHeaderView.frame.origin.y, 0.5, sectionHeaderView.frame.size.height)];
    lineView1.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [sectionHeaderView addSubview:lineView1];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake((sectionHeaderView.frame.size.width/1.5), sectionHeaderView.frame.origin.y, 0.5, sectionHeaderView.frame.size.height)];
    lineView2.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [sectionHeaderView addSubview:lineView2];
    
    return sectionHeaderView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"HomeTableCell";

    HomeTableCell *cell = (HomeTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[HomeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Filter by search bar input
    Group* group = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        group = [searchResults objectAtIndex:indexPath.row];
    } else {
        group = [groups objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = group.name;
    
    float groupBalance = [Bill getBalanceForGroupId:group.dbId];
    if(groupBalance > 0.0){
        cell.valueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", groupBalance];
        cell.valueLabel.textColor = [UIColor colorWithRed:65.0/255.0 green:148.0/255.0 blue:56.0/255.0 alpha:1.0f];
        float valueLabelX = cell.thumbnailStatusImageView.frame.origin.x-[cell.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:cell.valueLabel.font}].width - cell.thumbnailStatusImageView.frame.size.width/2;
        cell.valueLabel.frame = CGRectMake(valueLabelX, cell.valueLabel.frame.origin.y, cell.valueLabel.bounds.size.width, cell.valueLabel.bounds.size.height);
        cell.thumbnailStatusImageView.image = [UIImage imageNamed:@"green.png"];

    }else if(groupBalance == 0.0){
        cell.valueLabel.text = @"settle up";
        cell.valueLabel.textColor = [UIColor lightGrayColor];
        float valueLabelX = cell.thumbnailStatusImageView.frame.origin.x-[cell.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:cell.valueLabel.font}].width - cell.thumbnailStatusImageView.frame.size.width/2;;
        cell.valueLabel.frame = CGRectMake(valueLabelX, cell.valueLabel.frame.origin.y, cell.valueLabel.bounds.size.width, cell.valueLabel.bounds.size.height);
        cell.thumbnailStatusImageView.image = [UIImage imageNamed:@"gray.png"];
        
    }else{
        cell.valueLabel.text = [NSString stringWithFormat:@"%@%.2f", @"-$", groupBalance*-1.0];
        cell.valueLabel.textColor = [UIColor colorWithRed:198.0/255.0 green:31.0/255.0 blue:75.0/255.0 alpha:1.0f];
        float valueLabelX = cell.thumbnailStatusImageView.frame.origin.x-[cell.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:cell.valueLabel.font}].width - cell.thumbnailStatusImageView.frame.size.width/2;;
        cell.valueLabel.frame = CGRectMake(valueLabelX, cell.valueLabel.frame.origin.y, cell.valueLabel.bounds.size.width, cell.valueLabel.bounds.size.height);
        cell.thumbnailStatusImageView.image = [UIImage imageNamed:@"red.png"];
    }
    
    cell.nameLabel.frame = CGRectMake(cell.nameLabel.frame.origin.x, cell.nameLabel.frame.origin.y, cell.valueLabel.frame.origin.x - cell.nameLabel.frame.origin.x,cell.nameLabel.frame.origin.y);
    
    cell.thumbnailStatusImageView.layer.cornerRadius = cell.thumbnailStatusImageView.frame.size.width / 2;
    cell.thumbnailStatusImageView.clipsToBounds = YES;
    
    if(group.image){
        cell.thumbnailProfileImageView.image = group.image;
    }else{
        cell.thumbnailProfileImageView.image = [UIImage imageNamed:@"standard.jpg"];
    }
    cell.thumbnailProfileImageView.layer.cornerRadius = cell.thumbnailProfileImageView.frame.size.width / 2;
    cell.thumbnailProfileImageView.clipsToBounds = YES;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.height * 0.11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableView.frame.size.height * 0.15;
}

// Search bar methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [groups filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)dealloc {
    NSLog(@"dealloc - %@",[self class]);
}

@end
