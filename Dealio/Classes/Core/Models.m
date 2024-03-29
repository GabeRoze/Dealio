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
@synthesize favoriteList;
@synthesize dealView;
@synthesize featuredDeal;

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
        favoriteList = [NSMutableArray new];
        dealView = [NSMutableArray new];
        featuredDeal = [NSMutableDictionary new];
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

@implementation RegistrationData

@synthesize email;
@synthesize firstName;
@synthesize lastName;
@synthesize password;
@synthesize sex;
@synthesize foodDescription;
@synthesize age;
@synthesize ageString;
@synthesize ethnicity;
@synthesize ethnicityString;
@synthesize income;
@synthesize incomeString;
@synthesize acceptedTOS;

-(id)init
{
    if (self = [super init])
    {
        sex = @"0";
        foodDescription = @"";
        age = 0;
        ethnicity = 0;
        income = 0;
    }
    return self;
}

+(RegistrationData *)instance
{
    static RegistrationData *instance = nil;

    if (!instance)
    {
        instance = [RegistrationData new];
    }
    return instance;
}

+(void)clearSavedData
{
    RegistrationData.instance.email = nil;
    RegistrationData.instance.firstName = nil;
    RegistrationData.instance.lastName = nil;
    RegistrationData.instance.password = nil;
    RegistrationData.instance.sex = nil;
    RegistrationData.instance.foodDescription = nil;
    RegistrationData.instance.sex = nil;
    RegistrationData.instance.age = 0;
    RegistrationData.instance.ageString = @"0";
    RegistrationData.instance.ethnicity = 0;
    RegistrationData.instance.ethnicityString = @"0";
    RegistrationData.instance.income = 0;
    RegistrationData.instance.incomeString = @"0";
    RegistrationData.instance.acceptedTOS = NO;
}

@end


@implementation TipUsData

@synthesize businessName;
@synthesize dealName;
@synthesize detail;
@synthesize address;
@synthesize latitude;
@synthesize longitude;
@synthesize days;
@synthesize openTime;
@synthesize closeTime;

-(id)init
{
    if (self == [super init])
    {
        days = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", @"0", @"0" ,@"0", nil];
        openTime = -1;
        closeTime = -1;
    }
    return self;

}

+(TipUsData *)instance
{
    static TipUsData *instance = nil;

    if (!instance)
    {
        instance = [TipUsData new];
    }
    return instance;
}

@end