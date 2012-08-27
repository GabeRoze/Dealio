//
//  MapViewController.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CalculationHelper.h"
#import "Models.h"

@implementation MapViewController

@synthesize userMapView;

#pragma mark - View lifecycle
-(void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    for(MKAnnotationView *annotationView in views)
    {
        if(annotationView.annotation == mv.userLocation)
        {
            MKCoordinateRegion region;
            MKCoordinateSpan span;

            //originally 0.9
            span.latitudeDelta=0.01;
            span.longitudeDelta=0.01;
            CLLocationCoordinate2D location =mv.userLocation.coordinate;
            location = mv.userLocation.location.coordinate;
            region.span = span;
            region.center = location;
            [mv setRegion:region animated:YES];
            [mv regionThatFits:region];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self zoomOnUserLocation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self clearAndAddLocationPins];
}

- (IBAction)locateUserPressed:(id)sender
{
    [self zoomOnUserLocation];
}

-(void)zoomOnUserLocation
{
    MKCoordinateRegion zoomIn = userMapView.region;
    zoomIn.span.latitudeDelta = 0.01;
    zoomIn.span.longitudeDelta = 0.01;
    zoomIn.center.latitude = userMapView.userLocation.location.coordinate.latitude;
    zoomIn.center.longitude = userMapView.userLocation.location.coordinate.longitude;
    [userMapView setRegion:zoomIn animated:YES];
}

-(void)clearAndAddLocationPins
{
    [userMapView removeAnnotations:userMapView.annotations];

    for (NSUInteger i =0; i < DealData.instance.dealList.count; i++)
    {
        NSDictionary* dealData = [DealData.instance.dealList objectAtIndex:i];
        CLLocationCoordinate2D annotationCoord;

        annotationCoord.latitude = [[dealData objectForKey:@"latitude"] floatValue];
        annotationCoord.longitude = [[dealData objectForKey:@"longitude"] floatValue];

        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [dealData objectForKey:@"dealname"];
        annotationPoint.subtitle = [dealData objectForKey:@"businessname"];
        [userMapView addAnnotation:annotationPoint];
    }
}

@end
