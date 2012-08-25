//
//  MapViewCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-25.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface MapViewCell : UITableViewCell
{
    MapViewController *mapViewController;
}

@property (strong, nonatomic) MapViewController *mapViewController;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
