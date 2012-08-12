//
//  MapViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>



@interface MapViewController : UIViewController


@property (weak, nonatomic) IBOutlet MKMapView *userMapView;
- (IBAction)locateUserPressed:(id)sender;


-(void)zoomOnUserLocation;

@end
