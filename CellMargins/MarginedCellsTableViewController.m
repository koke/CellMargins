//
//  MarginedCellsTableViewController.m
//  CellMargins
//
//  Created by aerych on 11/23/15.
//  Copyright © 2015 aerych. All rights reserved.
//

#import "MarginedCellsTableViewController.h"

static NSString * const TableViewCellIdentifier = @"TableViewCell";

@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *customBackgroundView;
@end

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createBackgroundView];
    }
    return self;
}


- (void)createBackgroundView
{
    // The frame for the view assigned to selectedBackgroundView will always be sized to match
    // the contentView. Create a wrapper for this, and add the custom background view as its
    // subview.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];

    _customBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    _customBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _customBackgroundView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:_customBackgroundView];

    [self setSelectedBackgroundView:view];
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    CGFloat margin = ( CGRectGetWidth(self.frame) - 600.0 ) / 2.0;
    if (margin > 0) {
        self.layoutMargins = UIEdgeInsetsMake(0.0, margin, 0.0, margin);
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint convertedPoint = [self.window convertPoint:point toView:self.customBackgroundView];
    // Don't respond to taps in margins.
    if (!CGRectContainsPoint(self.customBackgroundView.bounds, convertedPoint)) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

@end



@interface MarginedCellsTableViewController ()
@end

@implementation MarginedCellsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
}


#pragma mark - TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = @"Example Text";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"sample"];

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Delete";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
