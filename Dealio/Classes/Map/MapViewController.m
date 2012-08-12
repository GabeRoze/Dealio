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

@implementation MapViewController
@synthesize userMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views{
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == mv.userLocation){
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
    
    
    
    
    /*
     CLLocationCoordinate2D mapCenter = mapView.centerCoordinate;
     mapCenter = [mapView 
     convertPoint:CGPointMake(1,mapView.frame.size.height/2.0)
     toCoordinateFromView:mapView];
     [mapView setCenterCoordinate:mapCenter animated:YES];
     
     
     MKCoordinateRegion theRegion = mapView.region;
     
     // Zoom out
     theRegion.span.longitudeDelta *= 0.01;
     theRegion.span.latitudeDelta *= 0.01;
     [mapView setRegion:theRegion animated:YES];
     */
    
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidUnload
{
    [self setUserMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)locateUserPressed:(id)sender {
    [self zoomOnUserLocation];
}

-(void)zoomOnUserLocation {
 
    
    MKCoordinateRegion zoomIn = userMapView.region;
    zoomIn.span.latitudeDelta = 0.01;
    zoomIn.span.longitudeDelta = 0.01;
    zoomIn.center.latitude = userMapView.userLocation.location.coordinate.latitude;
    zoomIn.center.longitude = userMapView.userLocation.location.coordinate.longitude;
    [userMapView setRegion:zoomIn animated:YES];
    
}


@end
