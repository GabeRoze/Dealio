//
//  Models.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Models.h"

@implementation Models

@end


@implementation SearchLocation

@synthesize locationManager;
@synthesize savedLocation;
@synthesize useCurrentLocation;
@synthesize savedAddress;

+ (SearchLocation*)instance
{
    static SearchLocation* instance = nil;

    if (!instance)
    {
        instance = [[SearchLocation alloc] initData];
    }

    return instance;
}

-(id)initData
{
    if (self = [super init])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];

        double longitude = [NSUserDefaults.standardUserDefaults doubleForKey:@"savedLongitude"];
        double latitude = [NSUserDefaults.standardUserDefaults doubleForKey:@"savedLatitude"];
        savedAddress = [NSUserDefaults.standardUserDefaults stringForKey:@"savedAddress"];
        savedLocation.longitude = longitude;
        savedLocation.latitude = latitude;
        useCurrentLocation = YES;
    }
    return self;
}

//-(void)setSavedLocationWith


-(CLLocationCoordinate2D)getCurrentLocation
{
    CLLocation *location = [locationManager location];
    return [location coordinate];
}

-(CLLocationCoordinate2D)getLocation
{
    if (useCurrentLocation)
    {
        return [self getCurrentLocation];
    }
    else
    {
        return savedLocation;
    }
}

@end
