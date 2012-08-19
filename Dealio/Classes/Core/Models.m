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

@implementation FilterData

@synthesize maximumSearchDistance;

+ (FilterData*)instance
{
    static FilterData* instance = nil;

    if (!instance)
    {
        instance = [[FilterData alloc] initData];
    }
    return instance;
}

-(id)initData
{
    if (self = [super init])
    {
        maximumSearchDistance = [NSUserDefaults.standardUserDefaults integerForKey:@"maximumSearchDistance"];
        if (!maximumSearchDistance)
        {
            maximumSearchDistance = 1;
        }
    }
    return self;
}

@end

@implementation SearchLocation

@synthesize locationManager;
@synthesize savedAddressCoordinate;
@synthesize useCurrentLocation;
@synthesize savedAddressString;

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
        savedAddressString = [NSUserDefaults.standardUserDefaults stringForKey:@"savedAddress"];
        savedAddressCoordinate.longitude = longitude;
        savedAddressCoordinate.latitude = latitude;
        useCurrentLocation = YES;
    }
    return self;
}

-(CLLocationCoordinate2D)getCurrentLocation
{
    CLLocation *location = locationManager.location;
    return location.coordinate;
}

-(CLLocationCoordinate2D)getLocation
{
    if (useCurrentLocation)
    {
        return [self getCurrentLocation];
    }
    else
    {
        return savedAddressCoordinate;
    }
}

@end
