//
//  Models.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Models : NSObject

@end


@interface SearchLocation : NSObject <CLLocationManagerDelegate>
{
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *savedAddress;
@property (assign) CLLocationCoordinate2D savedLocation;
@property (assign) BOOL useCurrentLocation;
+ (SearchLocation*)instance;
-(CLLocationCoordinate2D)getCurrentLocation;
-(CLLocationCoordinate2D)getLocation;

@end