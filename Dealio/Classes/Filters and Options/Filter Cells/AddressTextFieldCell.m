//
//  AdressTextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AddressTextFieldCell.h"
#import "ActionSheetPicker.h"
#import "UIAlertView+Blocks.h"

@implementation AddressTextFieldCell
@synthesize addressTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}

- (IBAction)addressTextFieldDonePressed:(id)sender
{
}

- (IBAction)addressTextFieldEditingDidEnd:(id)sender
{
    [NSUserDefaults.standardUserDefaults setObject:addressTextField.text forKey:@"savedAddress"];
    SearchLocation.instance.savedAddressString = addressTextField.text;

    if (addressTextField.text.length > 0)
        [self geoCodeAddressWithString:addressTextField.text];
}

-(void)geoCodeAddressWithString:(NSString *)address
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error){
        if (!error)
        {
            if (placemarks.count == 1)
            {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                [self saveCoordinates:placemark.location.coordinate];
            }
            else if (placemarks.count > 1)
            {
                NSMutableArray *addressArray = [NSMutableArray new];

                for(CLPlacemark *placemark in placemarks)
                {
                    NSArray *formattedAddressLines = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
                    NSString *addressLine = @"";
                    for (NSUInteger i = 0; i < formattedAddressLines.count; i++)
                    {
                        NSString *currAddress = [formattedAddressLines objectAtIndex:i];
                        if (i == 0)
                        {
                            addressLine = currAddress;
                        }
                        else
                        {
                            addressLine = [NSString stringWithFormat:@"%@, %@", addressLine, currAddress];
                        }
                    }
//                    NSLog(@"address line %@", addressLine);
                    [addressArray addObject:addressLine];
                }

                ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
                {
                    CLPlacemark *placemark = [placemarks objectAtIndex:selectedIndex];
                    [self saveCoordinates:placemark.location.coordinate];
                };
                [ActionSheetStringPicker showPickerWithTitle:@"Select A Distance" rows:addressArray initialSelection:0 doneBlock:done cancelBlock:nil origin:self];
            }
        }
        else
        {
            RIButtonItem *okayButton = [RIButtonItem item];
            okayButton.label = @"Okay";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Address"
                                                                message:@"Please enter another address"
                                                       cancelButtonItem:okayButton
                                                       otherButtonItems:nil];
            [alertView show];

            CLLocationCoordinate2D emptyCoordinate;
            emptyCoordinate.latitude = 9999;
            emptyCoordinate.longitude = 9999;
            [self saveCoordinates:emptyCoordinate];
        }
    }];
}


-(void)saveCoordinates:(CLLocationCoordinate2D)coordinate2D
{
    SearchLocation.instance.savedAddressCoordinate = coordinate2D;
    double longitude = coordinate2D.longitude;
    double latitude = coordinate2D.latitude;
    [NSUserDefaults.standardUserDefaults setDouble:latitude forKey:@"savedLongitude"];
    [NSUserDefaults.standardUserDefaults setDouble:longitude forKey:@"savedLatitude"];
}

@end
