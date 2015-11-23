//
//  TableViewController.m
//  CellMargins
//
//  Created by aerych on 11/20/15.
//  Copyright © 2015 aerych. All rights reserved.
//

#import "TableViewController.h"
#import "CenteredViewController.h"
#import "MarginedTableViewController.h"
#import "MarginedCellsTableViewController.h"

static NSString * const TableViewCellIdentifier = @"TableViewCell";

@interface TableViewController ()
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
}



#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSString *text;
    switch (indexPath.row) {
        case 0:
            text = @"Centered Table View";
            break;
        case 1:
            text = @"Margined Table View";
            break;
        case 2:
            text = @"Margined Cells";
            break;
        default:
            break;
    }

    cell.textLabel.text = text;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
            [self showCenteredTableView];
            break;
        case 1:
            [self showMarginedTableView];
            break;
        case 2:
            [self showMarginedCells];
            break;
        default:
            break;
    }
}


- (void)showCenteredTableView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CenteredTableView"];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)showMarginedTableView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MarginedTableView"];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)showMarginedCells
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MarginedCells"];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
