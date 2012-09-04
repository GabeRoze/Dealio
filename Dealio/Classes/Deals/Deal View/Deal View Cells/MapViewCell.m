//
//  MapViewCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-25.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "MapViewCell.h"
#import "Models.h"

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
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(mapChanged:) name:@"mapChanged" object:nil];

    return self;
}


-(void)mapChanged:(id)sender
{
    CLLocationCoordinate2D annotationCoord;

    annotationCoord.latitude = [TipUsData.instance.latitude floatValue];
    annotationCoord.longitude = [TipUsData.instance.longitude floatValue];

    [self.mapView removeAnnotations:self.mapView.annotations];

    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    [self.mapView addAnnotation:annotationPoint];

    MKCoordinateRegion zoomIn = self.mapView.region;
    zoomIn.span.latitudeDelta = 0.01;
    zoomIn.span.longitudeDelta = 0.01;
    zoomIn.center.latitude = annotationCoord.latitude;
    zoomIn.center.longitude = annotationCoord.longitude;
    [self.mapView setRegion:zoomIn animated:YES];
    [self.mapView setShowsUserLocation:NO];


    [self performSelector:@selector(selectLastAnnotation:) withObject:nil afterDelay:1.0f];
}


-(void)selectLastAnnotation:(id)sender
{
    [self.mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:YES];
    [self.mapView setShowsUserLocation:NO];
}


@end
