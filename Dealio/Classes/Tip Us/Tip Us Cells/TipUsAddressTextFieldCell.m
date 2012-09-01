//
//  AdressTextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "TipUsAddressTextFieldCell.h"
#import "ActionSheetPicker.h"
#import "UIAlertView+Blocks.h"
#import "ContactInfoCell.h"
#import "CalculationHelper.h"

@implementation TipUsAddressTextFieldCell

@synthesize addressTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TipUsAddressTextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    [self setAddressWithLatitude:SearchLocation.instance.getCurrentLocation.latitude longitude:SearchLocation.instance.getCurrentLocation.longitude];


    return self;
}

- (IBAction)addressTextFieldDonePressed:(id)sender
{
}

- (IBAction)addressTextFieldEditingDidEnd:(id)sender
{
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
                self.addressTextField.text = [CalculationHelper getAddressStringFromPlacemark:placemark];
            }
            else if (placemarks.count > 1)
            {
                NSMutableArray *addressArray = [NSMutableArray new];

                for(CLPlacemark *placemark in placemarks)
                {
                    [addressArray addObject:[CalculationHelper getAddressStringFromPlacemark:placemark]];
                }

                ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
                {
                    CLPlacemark *placemark = [placemarks objectAtIndex:selectedIndex];
                    self.addressTextField.text = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
                };
                [ActionSheetStringPicker showPickerWithTitle:@"Select Address" rows:addressArray initialSelection:0 doneBlock:done cancelBlock:nil origin:self];
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
            [addressTextField becomeFirstResponder];
        }
    }];
}


-(void)setAddressWithLatitude:(double)latitude longitude:(double)longitude
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(),^ {
            if (placemarks.count == 1)
            {
                CLPlacemark *place = [placemarks objectAtIndex:0];
                NSLog(@"place %@", place.addressDictionary);
//                NSString *address = [NSString stringWithFormat:@"%@, %@", [place.addressDictionary objectForKey:@"Street"], [place.addressDictionary objectForKey:@"City"]];
//                addressTextField.text = address;
                NSArray *addressArray = [place.addressDictionary objectForKey:@"FormattedAddressLines"];
                NSString *address = [NSString stringWithFormat:@"%@, %@, %@", [addressArray objectAtIndex:0], [addressArray objectAtIndex:1], [addressArray objectAtIndex:2]];
                addressTextField.text = address;

            }
        });
    }];
}

@end
