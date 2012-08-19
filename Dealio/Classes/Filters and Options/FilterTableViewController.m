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
#import "AddressTextFieldCell.h"

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

    [self setAddressTextFieldCellEnabled:!SearchLocation.instance.useCurrentLocation];
    [self updateAddressTextField];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = nil;

    if (indexPath.row == 0)
    {
        CellTableIdentifier = @"CellTableIdentifier";
        UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableViewCell)
        {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellTableIdentifier];
        }
        tableViewCell.detailTextLabel.font = [UIFont fontWithName:@"Eurofurencebold" size:22];
        tableViewCell.detailTextLabel.textColor = [UIColor cyanColor];
        tableViewCell.detailTextLabel.text = @"Filters";
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return  tableViewCell;
    }
    if (indexPath.row == 1)
    {
        CellTableIdentifier = @"CellTableIdentifier";
        UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableViewCell)
        {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellTableIdentifier];
        }

        tableViewCell.detailTextLabel.text = @"Use Gps";

        return  tableViewCell;
    }
    else if (indexPath.row == 2)
    {
        CellTableIdentifier = @"CellTableIdentifier";
        UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!tableViewCell)
        {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellTableIdentifier];
        }

        tableViewCell.detailTextLabel.text = @"Use Address";

        return  tableViewCell;
    }
    else if (indexPath.row == 3)
    {
        CellTableIdentifier = @"AddressTextFieldIdentifier";

        AddressTextFieldCell *addressTextFieldCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!addressTextFieldCell)
        {
            addressTextFieldCell = [AddressTextFieldCell new];
        }

        return  addressTextFieldCell;
    }
    else if (indexPath.row == 4)
    {
        CellTableIdentifier = @"MaximumDistanceCellIdentifier";
        MaximumDistanceCell *maximumDistanceCell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

        if (!maximumDistanceCell)
        {
            maximumDistanceCell = [MaximumDistanceCell new];
        }
        return maximumDistanceCell;
    }
    else if (indexPath.row == 5)
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
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 1)
    {
        [self setAddressTextFieldCellEnabled:NO];
    }
    else if (indexPath.row == 2)
    {
        [self setAddressTextFieldCellEnabled:YES];
    }
    else if (indexPath.row == 3)
    {
        AddressTextFieldCell *addressTextFieldCell = (AddressTextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        addressTextFieldCell.addressTextField.becomeFirstResponder;
    }
    else if (indexPath.row == 4)
    {

    }
    else if (indexPath.row == 5)
    {

    }
}


#pragma mark - Filter Cell Interaction

-(void)setAddressTextFieldCellEnabled:(BOOL)enabled
{
    SearchLocation.instance.useCurrentLocation = !enabled;
    UITableViewCell *gpsCell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *addressCell = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AddressTextFieldCell *addressTextFieldCell = (AddressTextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    if (!SearchLocation.instance.useCurrentLocation)
    {
        addressTextFieldCell.addressTextField.textColor = [UIColor blackColor];
        addressTextFieldCell.addressTextField.userInteractionEnabled = YES;
        addressCell.accessoryType = UITableViewCellAccessoryCheckmark;
        gpsCell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        addressTextFieldCell.addressTextField.textColor = [UIColor grayColor];
        addressTextFieldCell.addressTextField.userInteractionEnabled = NO;
        gpsCell.accessoryType = UITableViewCellAccessoryCheckmark;
        addressCell.accessoryType = UITableViewCellAccessoryNone;
    }
    [self updateAddressTextField];
}

-(void)updateAddressTextField
{
    AddressTextFieldCell *cell = (AddressTextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    if (SearchLocation.instance.useCurrentLocation)
    {
        [self setAddressWithLatitude:SearchLocation.instance.getCurrentLocation.latitude longitude:SearchLocation.instance.getCurrentLocation.longitude];
    }
    else //use address
    {
        if (SearchLocation.instance.savedAddressString.length > 0)
        {
            cell.addressTextField.text = SearchLocation.instance.savedAddressString;
//            [self setAddressWithLatitude:SearchLocation.instance.savedAddressCoordinate.latitude longitude:SearchLocation.instance.savedAddressCoordinate.longitude];
        }
        else
        {
            cell.addressTextField.text = nil;
            cell.addressTextField.placeholder = @"Enter Address";
        }
    }
}

-(void)setAddressWithLatitude:(double)latitude longitude:(double)longitude
{
    AddressTextFieldCell *cell = (AddressTextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(),^ {
            if (placemarks.count == 1)
            {
                CLPlacemark *place = [placemarks objectAtIndex:0];
                NSString *address = [NSString stringWithFormat:@"%@, %@", [place.addressDictionary objectForKey:@"Street"], [place.addressDictionary objectForKey:@"City"]];
                cell.addressTextField.text = address;
//                [self setAddressTextFieldCellEnabled:!SearchLocation.instance.useCurrentLocation];

            }
        });
    }];
}

@end
