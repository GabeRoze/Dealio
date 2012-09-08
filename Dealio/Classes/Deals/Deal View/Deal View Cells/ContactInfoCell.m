//
//  ContactInfoCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-24.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ContactInfoCell.h"
#import "Models.h"

@implementation ContactInfoCell

@synthesize leftImageView;
@synthesize contactLabel;
@synthesize contactType;
@synthesize longitude;
@synthesize latitude;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactInfoCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [backgroundImage addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(IBAction)cellTapped:(id)sender
{
    if (contactType == phone)
    {
        NSString *phone = [contactLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                [NSString stringWithFormat:@"tel://%@", phone]]];
    }
    else if (contactType == website)
    {
        [[UIApplication sharedApplication] openURL:
                [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", contactLabel.text]]];
    }
    else if (contactType == address)
    {
        CLLocationCoordinate2D start = SearchLocation.instance.getCurrentLocation;
        CLLocationCoordinate2D destination;
        destination.longitude = [longitude doubleValue];
        destination.latitude = [latitude doubleValue];

        NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%f,%f",
                                         start.latitude, start.longitude, destination.latitude, destination.longitude];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    }
}

@end
