//
//  FilterTableViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "FilterTableViewController.h"
#import "LocationSelectionCell.h"
#import "MaximumDistanceCell.h"
#import "UpdateButtonCell.h"

@implementation FilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    LocationSelectionCell *cell = (LocationSelectionCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.updateLocationDisplay;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = nil;

    if (indexPath.row == 0)
    {
        CellTableIdentifier = @"LocationSelectionCellIdentifier";
        LocationSelectionCell *locationSelectionCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!locationSelectionCell)
        {
            locationSelectionCell = [LocationSelectionCell new];
        }

        locationSelectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        locationSelectionCell.updateLocationDisplay;

        return locationSelectionCell;
    }
    else if (indexPath.row == 1)
    {
        CellTableIdentifier = @"MaximumDistanceCellIdentifier";
        MaximumDistanceCell *maximumDistanceCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!maximumDistanceCell)
        {
            maximumDistanceCell = [MaximumDistanceCell new];
        }
        return maximumDistanceCell;
    }
    else if (indexPath.row == 2)
    {
        CellTableIdentifier = @"UpdateButtonCellIdentifier";
        UpdateButtonCell *updateButtonCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!updateButtonCell)
        {
            updateButtonCell = [UpdateButtonCell new];
        }
        return updateButtonCell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 160;
        }
        else if (indexPath.row == 1)
        {
            return 44;
        }
        else if (indexPath.row == 2)
        {
            return 44;
        }
    }
}
@end
