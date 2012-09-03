//
//  CalculationHelper.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/4/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CalculationHelper.h"
#import <CoreLocation/CoreLocation.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation CalculationHelper

+(NSString *)checkStringNull:(NSString *)str
{
    if (str.length < 1)
    {
        return @"";
    }
    return str;
}

+(NSString *)getAddressStringFromPlacemark:(CLPlacemark *)placemark
{
    NSArray *formattedAddressLines = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
    NSString *addressLine = @"";
    for (NSUInteger i = 0; i < formattedAddressLines.count; i++)
    {
        NSString *currAddress = [formattedAddressLines objectAtIndex:i];
        if (i == 0)
        {
            addressLine = currAddress;
        }
        else
        {
            addressLine = [NSString stringWithFormat:@"%@, %@", addressLine, currAddress];
        }
    }
    return addressLine;
}

+ (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *) platformString
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}


+ (NSString*) convertLikesToRating:(NSString*)likes dislikes:(NSString*)dislikes
{
    int numLikes = [likes intValue];
    int numDislikes = [dislikes intValue];
    int denominator = numLikes + numDislikes;

    if (denominator == 0)
    {
        denominator = 1;
    }

    int rating = numLikes / (denominator);

    rating = rating*100;

    NSString* ratingString;

    if (rating == 0)
    {
        ratingString = @"Not enough votes";
    }
    else
    {
        ratingString = [NSString stringWithFormat:@"%i%",rating];
    }
    return ratingString;
}

+(NSString*)convert24HourTimesToString:(NSString *)startTime endTime:(NSString *)endTime
{
    int startTimeInt = [startTime intValue];
    int endTimeInt = [endTime intValue];

    NSString* startTimeStamp = @"AM";
    NSString* endTimeStamp = @"AM";
    //convert strings to 12 hour
    if (startTimeInt == 0)
    {
        startTimeInt = 12;
    }
    else if (startTimeInt >= 12)
    {
        startTimeStamp = @"PM";
        if (startTimeInt > 12)
        {
            startTimeInt -= 12;
        }
    }
    if (endTimeInt == 0)
    {
        endTimeInt = 12;
    }
    else if (endTimeInt >= 12)
    {
        endTimeStamp = @"PM";
        if (endTimeInt > 12)
        {
            endTimeInt -= 12;
        }
    }
    NSString* returnString = [NSString stringWithFormat:@"%i%@ - %i%@", startTimeInt, startTimeStamp, endTimeInt, endTimeStamp ];

    return returnString;
}

+(NSString*) convertIntToDay:(int)num
{
    NSString* returnString;

    switch (num)
    {
        case 0:
            returnString = @"sunday";
            break;
        case 1:
            returnString = @"monday";
            break;
        case 2:
            returnString = @"tuesday";
            break;
        case 3:
            returnString = @"wednesday";
            break;
        case 4:
            returnString = @"thursday";
            break;
        case 5:
            returnString = @"friday";
            break;
        case 6:
            returnString = @"saturday";
            break;
        default:
            break;
    }
    return returnString;
}

+(NSMutableURLRequest*) getURLRequest:(NSString*)functionURL withData:(NSString*)data
{
    NSString* urlAsString = data;
    NSData *myRequestData = [NSData dataWithBytes: [urlAsString UTF8String] length:[urlAsString length]];
    NSURL* url = [NSURL URLWithString:functionURL];

    NSLog(@"function url : %@ data %@", functionURL,data);

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:myRequestData];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    return urlRequest;
}

+(UILabel*) createNavBarLabelWithTitle:(NSString*)title
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //Create label
    UILabel *label =  [[UILabel alloc] initWithFrame: CGRectZero];
    //Create shadow
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont fontWithName:@"Eurofurenceregular" size:30]];
    label.text = [title copy];
    [label sizeToFit];

    label.textAlignment = UITextAlignmentCenter;

    CGRect frame = label.frame;
    frame.origin.x = (width/2) - (label.frame.size.width/2);
    label.frame = frame;
    frame.origin.y =  22 - (label.frame.size.height/2);
    label.frame = frame;

    return label;
}
/*taken from

 http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/

 */
+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(BOOL) doesPasswordContainsLettersAndNumbers:(NSString *)checkString
{
    NSString *alphaRegex = @"[A-Z0-9a-z]|[A-Za-z]+[0-9]+|[0-9]+[A-Za-z]+";
    NSPredicate *alphaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaRegex];
    BOOL containsLetters = [alphaTest evaluateWithObject:checkString];
    if (containsLetters == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSMutableArray*) sortAndFormatDealListData:(NSMutableArray*)xmlData atLocation:(CLLocation*)currentLocation
{
    //Perform distance calculation
    NSMutableArray* returnArray = [NSMutableArray new];

//    NSLog(@"xml data %@", xmlData);

//    for (id object in xmlData)
//    {
//        NSMutableDictionary* rowData = (NSMutableDictionary*)object;
//
//        //Get the restaurants location
//        CLLocation *restaurantLocation = [[CLLocation alloc] initWithLatitude:[[rowData objectForKey:@"latitude"] doubleValue] longitude:[[rowData objectForKey:@"longitude"] doubleValue]];
//        //Get the distance to the restaurant in meters
//        CLLocationDistance distanceFloat = [currentLocation distanceFromLocation:restaurantLocation];
//
//        NSString* distanceString = [NSString stringWithFormat:@"%f", distanceFloat];
//
//        [rowData setObject:distanceString forKey:@"distance"];
//        [returnArray addObject:rowData];
//    }

//    NSArray *sortedArray = [[NSMutableArray alloc] init];
//    sortedArray = [self quicksort:xmlData];



//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
//    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
//    NSArray *sortedArray;
//    sortedArray = [xmlData sortedArrayUsingDescriptors:sortDescriptors];
//    NSLog(@"sorted array %@", xmlData);
//    NSLog(@"sorted array count %i", sortedArray.count);
//    NSLog(@"xml data array count %i", xmlData.count);


//    //format sorted results
//    for (id object in xmlData)
//    {
//        NSMutableDictionary* rowData = (NSMutableDictionary*)object;
//
//        NSString* distanceString = [rowData objectForKey:@"distance"];
//
//        float distanceFloat = [distanceString floatValue];
//
//        if (distanceFloat < 1000)
//        {
//            int distanceInt = (int) distanceFloat;
//            distanceString = [NSString stringWithFormat:@"(%im)", distanceInt];
//        }
//        else
//        {
//            distanceFloat = distanceFloat/1000;
//            distanceString = [NSString stringWithFormat:@"(%.1fkm)", distanceFloat];
//        }
//        [rowData setObject:distanceString forKey:@"distance"];
//    }
    return [[NSMutableArray alloc] initWithArray:xmlData];
}

+(NSMutableArray*)mergeSort:(NSMutableArray*)unsortedArray
{
    NSMutableDictionary* rowData = [[NSMutableDictionary alloc] init];
    //if list size is 1, consider sorted
    if ([unsortedArray count] <= 1)
    {
        return unsortedArray;
    }
    //else  list size > 1 so split into 2 sublists
    NSMutableArray* leftArray = [[NSMutableArray alloc] init];
    NSMutableArray* rightArray = [[NSMutableArray alloc] init];
    int middle = [unsortedArray count]/2;

    //add to left array
    for (int i = 0; i < middle; i++)
    {
        rowData = [unsortedArray objectAtIndex:i];
        [leftArray addObject:rowData];
    }
    //add to right array
    for (int i = middle; i < [unsortedArray count]; i++)
    {
        rowData = [unsortedArray objectAtIndex:i];
        [rightArray addObject:rowData];
    }

    leftArray = [self mergeSort:leftArray];
    rightArray = [self mergeSort:rightArray];

    NSMutableArray* mergedArray = [[NSMutableArray alloc] init];
    //add to left array
    for (int i = 0; i < [leftArray count]; i++)
    {
        rowData = [leftArray objectAtIndex:i];
        [mergedArray addObject:rowData];
    }
    //add to right array
    for (int i = 0; i < [rightArray count]; i++)
    {
        rowData = [rightArray objectAtIndex:i];
        [mergedArray addObject:rowData];
    }

    return mergedArray;
}


+(NSMutableArray*)quicksort:(NSMutableArray*)unsortedArray
{
    if ([unsortedArray count] <= 1)
    {
        return unsortedArray;
    }

    int pivot = [unsortedArray count]/2;
    NSMutableArray* lesserArray = [[NSMutableArray alloc] init];
    NSMutableArray* greaterArray = [[NSMutableArray alloc] init];
    int sameAsPivot = 0;

    //NSMutableDictionary* rowData = [[NSMutableDictionary alloc] init];

    for (int i = 0; i < [unsortedArray count]; i++)
    {
        if ( [[[unsortedArray objectAtIndex:i] objectForKey:@"distance"]floatValue] > [[[unsortedArray objectAtIndex:pivot]objectForKey:@"distance"]floatValue] ) {
            [greaterArray addObject:[unsortedArray objectAtIndex:i]];
        }
        else if ( [[[unsortedArray objectAtIndex:i] objectForKey:@"distance"]floatValue] < [[[unsortedArray objectAtIndex:pivot]objectForKey:@"distance"]floatValue] ) {
            [lesserArray addObject:[unsortedArray objectAtIndex:i]];
        }
        else {
            sameAsPivot++;
        }
    }

    lesserArray = [self quicksort:lesserArray];

    for (int i = 0; i < sameAsPivot; i++)
    {
        [lesserArray addObject:[unsortedArray objectAtIndex:pivot]];
    }

    greaterArray = [self quicksort:greaterArray];

    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < [lesserArray count]; i++)
    {
        [sortedArray addObject:[lesserArray objectAtIndex:i]];
    }

    for (int i = 0; i < [greaterArray count]; i++)
    {
        [sortedArray addObject:[greaterArray objectAtIndex:i]];
    }

    return sortedArray;
}


+(NSString *)convertFloatToString:(double)r
{
    return [NSString stringWithFormat:@"%f", r];
}

+(int)convertMaximumDistanceStringToInt:(NSString *)maximumDistanceString
{
    if ([maximumDistanceString isEqualToString:@"1 km"])
    {
        return 1;
    }
    else if ([maximumDistanceString isEqualToString:@"2 km"])
    {
        return 2;
    }
    else if ([maximumDistanceString isEqualToString:@"5 km"])
    {
        return 5;
    }
    else if ([maximumDistanceString isEqualToString:@"10 km"])
    {
        return 10;
    }
    return 0;
}

+(CGFloat)calculateCellHeightWithString:(NSString *)string forWidth:(CGFloat)width
{
    UIFont *cellFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:16.0];
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    CGSize labelSize = [string sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height+25;
}

+(NSString *)formatDistance:(NSString *)distance
{
    NSString *distanceString = nil;
    float distanceFloat = [distance floatValue];

    if (distanceFloat < 1000)
    {
        int distanceInt = (int) distanceFloat;
        distanceString = [NSString stringWithFormat:@"(%im)", distanceInt];
    }
    else
    {
        distanceFloat = distanceFloat/1000;
        distanceString = [NSString stringWithFormat:@"(%.1fkm)", distanceFloat];
    }

    return distanceString;
}

@end
