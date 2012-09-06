//
//  FilterTableViewController.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "FilterTableViewController.h"
#import "LocationSelectionCell.h"
#import "MaximumDistanceCell.h"
#import "UpdateButtonCell.h"
#import "AddressTextFieldCell.h"
#import "ActionSheetPicker.h"
#import "CalculationHelper.h"
#import "UIAlertView+Blocks.h"

@implementation FilterTableViewController

//@synthesize dealListViewController;
//@synthesize dealListTableView;

//-(id)initWithDealListViewController:(DealListViewController *)theDealListViewController
//{
//    if (self = [super init])
//    {
//        dealListViewController = theDealListViewController;
//        dealListTableView = theDealListTableView;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
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

    MaximumDistanceCell *cell = (MaximumDistanceCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.maxKmLabel.text = [NSString stringWithFormat:@"%i km", FilterData.instance.maximumSearchDistance];

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
        tableViewCell.detailTextLabel.font = [UIFont fontWithName:@"Rokkitt-Bold" size:26];
        tableViewCell.detailTextLabel.textColor = [UIColor colorWithRed:0 green:131.0/255.0 blue:121.0/255.0 alpha:1.0];
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
        tableViewCell.detailTextLabel.text = @"Use Current Location (GPS)";

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
        ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
        {
            MaximumDistanceCell *maximumDistanceCell = (MaximumDistanceCell *)[tableView cellForRowAtIndexPath:indexPath];
            maximumDistanceCell.maxKmLabel.text = selectedValue;
            FilterData.instance.maximumSearchDistance = [CalculationHelper convertMaximumDistanceStringToInt:selectedValue];
            [NSUserDefaults.standardUserDefaults setObject:selectedValue forKey:@"maximumSearchDistance"];
        };
        NSArray *colors = [NSArray arrayWithObjects:@"1 km", @"2 km", @"5 km", @"10 km", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select A Distance" rows:colors initialSelection:0 doneBlock:done cancelBlock:nil origin:self.view];
    }
    else if (indexPath.row == 5)
    {
        AddressTextFieldCell *addressTextFieldCell = (AddressTextFieldCell *)[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

        if (!SearchLocation.instance.useCurrentLocation
                && SearchLocation.instance.savedAddressCoordinate.latitude == 9999
                && SearchLocation.instance.savedAddressCoordinate.longitude == 9999
                || addressTextFieldCell.addressTextField.text.length < 1
                        && !SearchLocation.instance.useCurrentLocation)
        {
            RIButtonItem *okayButton = [RIButtonItem item];
            okayButton.label = @"Okay";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Address"
                                                                message:@"Please enter another address"
                                                       cancelButtonItem:okayButton
                                                       otherButtonItems:nil];
            [alertView show];
        }
        else
        {
            UIImageView *currentDay = (UIImageView *)[DealListViewController.instance.dayButtons objectAtIndex:(DealListViewController.instance.currentSelectedDay)];
            currentDay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selected_day_button_color"]];
            UILabel *currentDayLabel = (UILabel *)[DealListViewController.instance.dayLabels objectAtIndex:(DealListViewController.instance.currentSelectedDay)];
            [currentDayLabel setTextColor:[UIColor whiteColor]];
            DealListViewController.instance.filterButtonTapped;
        }
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
        }
        else
        {
//            [self setAddressWithLatitude:SearchLocation.instance.getCurrentLocation.latitude longitude:SearchLocation.instance.getCurrentLocation.longitude];
//            cell.addressTextField.placeholder =
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
