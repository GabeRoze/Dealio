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
            maximumSearchDistance = 5;
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

//        NSLog(@"long %f, lat %f", longitude, latitude);
//        if (savedAddressString.length < 1)
//        {
//            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//            CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
//               {
//                   dispatch_async(dispatch_get_main_queue(),^ {
//                       if (placemarks.count == 1)
//                       {
//                           CLPlacemark *place = [placemarks objectAtIndex:0];
//                           NSString *address = [NSString stringWithFormat:@"%@, %@", [place.addressDictionary objectForKey:@"Street"], [place.addressDictionary objectForKey:@"City"]];
//                           savedAddressString = address;
//                       }
//                   });
//               }];
//        }
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


@implementation DealData

@synthesize dealList;
@synthesize dealView;

+ (DealData*)instance
{
    static DealData* instance = nil;

    if (!instance)
    {
        instance = [DealData new];
    }
    return instance;
}

-(id)init
{
    if (self = [super init])
    {
        dealList = [NSMutableArray new];
        dealView = [NSMutableArray new];
    }
    return self;
}


@end


@implementation UserData

@synthesize email;
@synthesize firstName;
@synthesize lastName;

+(UserData *)instance
{
    static UserData * instance = nil;

    if (!instance)
    {
        instance = [UserData new];
    }
    return instance;
}

@end