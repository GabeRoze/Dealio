//
//  FilterTableViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "FilterTableViewController.h"
#import "LocationSelectionCell.h"

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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = nil;

    if (indexPath.row == 0)
    {
        CellTableIdentifier = @"locationSelectionCellIdentifier";
        LocationSelectionCell *locationSelectionCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!locationSelectionCell)
        {
            locationSelectionCell = [LocationSelectionCell new];
        }

        locationSelectionCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return locationSelectionCell;
    }

//    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
//
//    if (!tableViewCell)
//    {
//        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
//    }
//
//    return tableViewCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 206;
        }
    }
}
@end
