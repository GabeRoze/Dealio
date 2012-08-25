//
//  MapViewCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-25.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "MapViewCell.h"

@implementation MapViewCell

@synthesize mapViewController;
@synthesize mapView;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MapViewCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];

    return self;
}


@end
