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

+ (DealData*)instance;
@end
