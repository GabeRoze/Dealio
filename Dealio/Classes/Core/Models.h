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

@interface FilterData : NSObject
{
}

@property (nonatomic, assign) int maximumSearchDistance;

+ (FilterData*)instance;

@end

@interface SearchLocation : NSObject <CLLocationManagerDelegate>
{
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *savedAddressString;
@property (assign) CLLocationCoordinate2D savedAddressCoordinate;
@property (assign) BOOL useCurrentLocation;
+ (SearchLocation*)instance;
-(CLLocationCoordinate2D)getCurrentLocation;
-(CLLocationCoordinate2D)getLocation;


@end

@interface DealData : NSObject

@property (nonatomic, strong) NSMutableArray *dealList;
@property (nonatomic, strong) NSMutableArray *dealView;
@property (nonatomic, strong) NSMutableDictionary *featuredDeal;

+ (DealData*)instance;
@end

@interface UserData : NSObject

+(UserData *)instance;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@end


@interface RegistrationData : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *foodDescription;
@property (assign, nonatomic) int age;
@property (strong, nonatomic) NSString *ageString;
@property (assign, nonatomic) int ethnicity;
@property (strong, nonatomic) NSString *ethnicityString;
@property (assign, nonatomic) int income;
@property (strong, nonatomic) NSString *incomeString;
@property (assign, nonatomic) BOOL acceptedTOS;

+(RegistrationData *)instance;

@end


@interface TipUsData : NSObject

@property (strong, nonatomic) NSString *businessName;
@property (strong, nonatomic) NSString *dealName;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSMutableArray *days;
@property (assign, nonatomic) int openTime;
@property (assign, nonatomic) int closeTime;


+(TipUsData *)instance;

@end
