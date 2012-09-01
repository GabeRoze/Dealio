//
//  CalculationHelper.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/4/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CalculationHelper : NSObject

+(NSString *)checkStringNull:(NSString *)str;
+(NSString *)getAddressStringFromPlacemark:(CLPlacemark *)placemark;
+ (NSString *) platformString;
+(NSString*) convertLikesToRating:(NSString*)likes dislikes:(NSString*)dislikes;
+(NSString*) convertIntToDay:(int)num;
+(NSString*) convert24HourTimesToString:(NSString*)startTime endTime:(NSString*)endTime;
+(NSMutableURLRequest*) getURLRequest:(NSString*)functionURL withData:(NSString*)data;
+(UILabel*) createNavBarLabelWithTitle:(NSString*)title;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(BOOL) doesPasswordContainsLettersAndNumbers:(NSString *)checkString;
+(NSMutableArray*) sortAndFormatDealListData:(NSMutableArray*)xmlData atLocation:(CLLocation*)currentLocation;
+(NSMutableArray*)mergeSort:(NSMutableArray*)unsortedArray;
+(NSMutableArray*)quicksort:(NSMutableArray*)unsortedArray;
+(NSString *)convertFloatToString:(double)r;
+(int)convertMaximumDistanceStringToInt:(NSString *)maximumDistanceString;
+(CGFloat)calculateCellHeightWithString:(NSString *)string forWidth:(CGFloat)width;

@end
