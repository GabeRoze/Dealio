//
//  LocationSelectionCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LocationSelectionCell.h"

@implementation LocationSelectionCell

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LocationSelectionCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    gpsButton.highlighted = YES;
    self.updateLocationDisplay;

    return self;
}

//-(void)updateLocationDisplay
//{
//    if (SearchLocation.instance.savedAddressString)
//    {
//        addressTextField.text = SearchLocation.instance.savedAddressString;
//    }
//    else if ([SearchLocation instance].useCurrentLocation)
//    {
//        [self setAddressWithLatitude:SearchLocation.instance.getCurrentLocation.latitude longitude:SearchLocation.instance.getCurrentLocation.longitude];
//    }
//    else
//    {
//        [self setAddressWithLatitude:SearchLocation.instance.savedAddressCoordinate.latitude longitude:SearchLocation.instance.savedAddressCoordinate.longitude];
//    }
//}

//-(void)setAddressWithLatitude:(double)latitude longitude:(double)longitude
//{
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
//    {
//        dispatch_async(dispatch_get_main_queue(),^ {
//            if (placemarks.count == 1)
//            {
//                CLPlacemark *place = [placemarks objectAtIndex:0];
//                NSString *address = [NSString stringWithFormat:@"%@, %@", [place.addressDictionary objectForKey:@"Street"], [place.addressDictionary objectForKey:@"City"]];
//
//                if (SearchLocation.instance.useCurrentLocation)
//                {
//                    addressTextField.text = address;
//                    addressTextField.textColor = [UIColor grayColor];
//                }
//                else
//                {
//                    addressTextField.text = address;
//                    addressTextField.textColor = [UIColor blackColor];
//                }
//            }
//        });
//    }];
//}

-(void)flipGpsButtonOn
{
    gpsButton.highlighted = YES;
}

-(void)flipAddressButtonOn
{
    addressButton.highlighted = YES;
}

- (IBAction)gpsButtonTapped:(id)sender
{
    SearchLocation.instance.useCurrentLocation = YES;
    [self performSelector:@selector(flipGpsButtonOn) withObject:nil afterDelay:0.0];
    addressButton.highlighted = NO;
    addressTextField.userInteractionEnabled = NO;
    addressTextField.textColor = [UIColor grayColor];
    [self updateLocationDisplay];
}

- (IBAction)addressButtonTapped:(id)sender
{
    SearchLocation.instance.useCurrentLocation = NO;
    [self performSelector:@selector(flipAddressButtonOn) withObject:nil afterDelay:0.0];
    gpsButton.highlighted = NO;
    addressTextField.userInteractionEnabled = YES;
    addressTextField.textColor = [UIColor blackColor];
}

- (IBAction)addressChanged:(id)sender
{
    [NSUserDefaults.standardUserDefaults setObject:addressTextField.text forKey:@"savedAddress"];
    SearchLocation.instance.savedAddressString = addressTextField.text;
}

@end
