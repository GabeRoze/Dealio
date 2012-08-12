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



+ (NSString*) convertLikesToRating:(NSString*)likes dislikes:(NSString*)dislikes;
+(NSString*) convertIntToDay:(int)num;
+(NSString*) convert24HourTimesToString:(NSString*)startTime endTime:(NSString*)endTime;
+(NSMutableURLRequest*) getURLRequest:(NSString*)functionURL withData:(NSString*)data;
+(UILabel*) createNavBarLabelWithTitle:(NSString*)title;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(BOOL) doesPasswordContainsLettersAndNumbers:(NSString *)checkString;
+(NSMutableArray*) sortAndFormatDealListData:(NSMutableArray*)xmlData atLocation:(CLLocation*)currentLocation;
+(NSMutableArray*)mergeSort:(NSMutableArray*)unsortedArray;
+(NSMutableArray*)quicksort:(NSMutableArray*)unsortedArray;
@end
