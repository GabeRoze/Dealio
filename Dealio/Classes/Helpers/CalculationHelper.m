//
//  CalculationHelper.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/4/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CalculationHelper.h"
#import <CoreLocation/CoreLocation.h>

@implementation CalculationHelper

+ (NSString*) convertLikesToRating:(NSString*)likes dislikes:(NSString*)dislikes {


    //NSLog(@"helper likes %@", likes);
    //NSLog(@"helper dislikes %@", dislikes);

    int numLikes = [likes intValue];
    int numDislikes = [dislikes intValue];

    //NSLog(@"likes:%i dislikes:%i", numLikes, numDislikes);


    /*

     Check to see if the denominator of like % calulation is zero
     If 0, set to 1
     Therefore no calculation error
     Will still return 0


     */
    int denominator = numLikes + numDislikes;
    if (denominator == 0) {
        denominator = 1;
    }

    int rating = numLikes / (denominator);

    rating = rating*100;

    NSString* ratingString;

    if (rating == 0) {
        ratingString = @"Not enough votes";
    }
    else {
        ratingString = [NSString stringWithFormat:@"%i%",rating];
    }

    //NSLog(@"ratingString: %@", ratingString);

    return ratingString;

}

+(NSString*)convert24HourTimesToString:(NSString *)startTime endTime:(NSString *)endTime {

    int startTimeInt = [startTime intValue];
    int endTimeInt = [endTime intValue];

    NSString* startTimeStamp = @"AM";
    NSString* endTimeStamp = @"AM";

    //convert strings to 12 hour

    if (startTimeInt == 0) {

        startTimeInt = 12;

    }
    else if (startTimeInt >= 12) {


        startTimeStamp = @"PM";

        if (startTimeInt > 12) {
            startTimeInt -= 12;
        }



    }

    if (endTimeInt == 0) {

        endTimeInt = 12;

    }
    else if (endTimeInt >= 12) {

        endTimeStamp = @"PM";


        if (endTimeInt > 12) {
            endTimeInt -= 12;
        }

    }




    NSString* returnString = [NSString stringWithFormat:@"%i%@ - %i%@", startTimeInt, startTimeStamp, endTimeInt, endTimeStamp ];

    return returnString;


}



+(NSString*) convertIntToDay:(int)num {


    NSString* returnString;

    switch (num) {

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



+(NSMutableURLRequest*) getURLRequest:(NSString*)functionURL withData:(NSString*)data {

    //data0 = url
    //data1 = appended data


    /*
     NSString* urlAsString = @"";
     NSString* emailString = [NSString stringWithFormat:@"useremail=%@",(NSString*)[userData objectAtIndex:0] ];
     NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
     NSString* passwordString = [NSString stringWithFormat:@"&userpw=%@",encryptedPassword ];



     urlAsString = [urlAsString stringByAppendingString:emailString];
     urlAsString = [urlAsString stringByAppendingString:passwordString];

     */

    NSString* urlAsString = data;
//    NSLog(@"urlstr: %@", urlAsString);
    NSData *myRequestData = [NSData dataWithBytes: [urlAsString UTF8String] length: [urlAsString length]];

    //    NSURL* url = [NSURL URLWithString:@"http://www.cinnux.com/userlogin-func.php/"];

    NSURL* url = [NSURL URLWithString:functionURL];


    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:myRequestData];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];


    return urlRequest;
}


+(UILabel*) createNavBarLabelWithTitle:(NSString*)title {

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

    /*

     //Lists all available fonts in log
     NSArray *familyNames = [UIFont familyNames];
     for(NSString *family in familyNames)
     {
     NSLog(@"Font Family %@",family);
     NSArray *availableFonts = [UIFont fontNamesForFamilyName:family];
     for(NSString *ft in availableFonts)
     {
     NSLog(@"Font: %@",ft);
     }
     }
     */

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
    //not[A-Za-z] OR [0-9]
    NSPredicate *alphaTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaRegex];
    BOOL containsLetters = [alphaTest evaluateWithObject:checkString];
    /*
     NSString *numRegex = @"[0-9]*";
     NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
     BOOL containsNumbers = [numTest evaluateWithObject:checkString];
     */
    NSLog(@"contains letters?  %d", containsLetters);
    /*
     NSLog(@"contains numbers??  %d", containsNumbers);
     */

    if (containsLetters == YES) {
        NSLog(@"YESPASS!");
        return YES;
    }
    else {
        NSLog(@"NO FAIL!");
        return NO;
    }


}

+(NSMutableArray*) sortAndFormatDealListData:(NSMutableArray*)xmlData atLocation:(CLLocation*)currentLocation {



    //Perform distance calculation

    NSMutableArray* returnArray = [[NSMutableArray alloc] init];

    for (id object in xmlData)
    {
        NSMutableDictionary* rowData = (NSMutableDictionary*)object;

        //Get the restaurants location
        CLLocation *restaurantLocation = [[CLLocation alloc] initWithLatitude:[[rowData objectForKey:@"storelatitude"] doubleValue] longitude:[[rowData objectForKey:@"storelongitude"] doubleValue]];
        //Get the distance to the restaurant in meters
        CLLocationDistance distanceFloat = [currentLocation distanceFromLocation:restaurantLocation];

        NSString* distanceString = [NSString stringWithFormat:@"%f", distanceFloat];

        [rowData setObject:distanceString forKey:@"calculateddistance"];
        [returnArray addObject:rowData];

        /*
         //String to be converted
         NSString* distanceString;

         if (distanceFloat < 1000) {

         int distanceInt = (int) distanceFloat;
         distanceString = [NSString stringWithFormat:@"(%im)", distanceInt];
         }
         else {
         distanceFloat = distanceFloat/1000;
         distanceString = [NSString stringWithFormat:@"(%.1fkm)", distanceFloat];
         }

         [rowData setObject:distanceString forKey:@"calculateddistance"];
         [returnArray addObject:rowData];
         */
    }

    //Sort array


    NSArray* sortedArray = [[NSArray alloc] init];


    /*
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"calculateddistance" ascending:YES];

    NSArray *sortDescriptors = [NSArray arrayWithObjects:aSortDescriptor, nil];

    sortedArray =    [returnArray sortedArrayUsingDescriptors:sortDescriptors];

     */

    //[returnArray sortUsingDescriptors:[NSMutableArray arrayWithObject:aSortDescriptor]];
    //    returnArray = [self mergeSort:returnArray];


    sortedArray = [self quicksort:returnArray];

    //format sorted results
    for (id object in xmlData)
    {
        NSMutableDictionary* rowData = (NSMutableDictionary*)object;

        NSString* distanceString = [rowData objectForKey:@"calculateddistance"];

        //NSLog(@"distance: %@",distanceString);

        float distanceFloat = [distanceString floatValue];

        if (distanceFloat < 1000) {

            int distanceInt = (int) distanceFloat;
            distanceString = [NSString stringWithFormat:@"(%im)", distanceInt];
        }
        else {
            distanceFloat = distanceFloat/1000;
            distanceString = [NSString stringWithFormat:@"(%.1fkm)", distanceFloat];
        }

        [rowData setObject:distanceString forKey:@"calculateddistance"];
    }

    //Update values in array

    /*
     for (int i = 0; i < [returnArray count] ; i++) {

     NSMutableDictionary* rowData = [returnArray objectAtIndex:i];
     NSString* distanceString = [rowData objectForKey:@"calculateddistance"];
     NSLog(@"####### distance: %@",distanceString);


     }*/


    return sortedArray;



}


+(NSMutableArray*)mergeSort:(NSMutableArray*)unsortedArray {


    NSMutableDictionary* rowData = [[NSMutableDictionary alloc] init];

    //if list size is 1, consider sorted
    if ([unsortedArray count] <= 1) {
        return unsortedArray;
    }
    //else  list size > 1 so split into 2 sublists
    NSMutableArray* leftArray = [[NSMutableArray alloc] init];
    NSMutableArray* rightArray = [[NSMutableArray alloc] init];
    int middle = [unsortedArray count]/2;

    //add to left array
    for (int i = 0; i < middle; i++) {
        rowData = [unsortedArray objectAtIndex:i];
        [leftArray addObject:rowData];

    }
    //add to right array
    for (int i = middle; i < [unsortedArray count]; i++) {
        rowData = [unsortedArray objectAtIndex:i];
        [rightArray addObject:rowData];

    }

    leftArray = [self mergeSort:leftArray];
    rightArray = [self mergeSort:rightArray];

    NSMutableArray* mergedArray = [[NSMutableArray alloc] init];
    //add to left array
    for (int i = 0; i < [leftArray count]; i++) {
        rowData = [leftArray objectAtIndex:i];
        [mergedArray addObject:rowData];
    }
    //add to right array
    for (int i = 0; i < [rightArray count]; i++) {
        rowData = [rightArray objectAtIndex:i];
        [mergedArray addObject:rowData];
    }

    return mergedArray;
}


+(NSMutableArray*)quicksort:(NSMutableArray*)unsortedArray {

    if ([unsortedArray count] <= 1) {
        return unsortedArray;
    }

    int pivot = [unsortedArray count]/2;
    NSMutableArray* lesserArray = [[NSMutableArray alloc] init];
    NSMutableArray* greaterArray = [[NSMutableArray alloc] init];
    int sameAsPivot = 0;

    //NSMutableDictionary* rowData = [[NSMutableDictionary alloc] init];

    for (int i = 0; i < [unsortedArray count]; i++) {
        if ( [[[unsortedArray objectAtIndex:i] objectForKey:@"calculateddistance"]floatValue] > [[[unsortedArray objectAtIndex:pivot]objectForKey:@"calculateddistance"]floatValue] ) {
            [greaterArray addObject:[unsortedArray objectAtIndex:i]];
        }
        else if ( [[[unsortedArray objectAtIndex:i] objectForKey:@"calculateddistance"]floatValue] < [[[unsortedArray objectAtIndex:pivot]objectForKey:@"calculateddistance"]floatValue] ) {
            [lesserArray addObject:[unsortedArray objectAtIndex:i]];
        }
        else {
            sameAsPivot++;
        }
    }

    lesserArray = [self quicksort:lesserArray];

    for (int i = 0; i < sameAsPivot; i++) {
        [lesserArray addObject:[unsortedArray objectAtIndex:pivot]];

    }

    greaterArray = [self quicksort:greaterArray];

    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < [lesserArray count]; i++) {
        [sortedArray addObject:[lesserArray objectAtIndex:i]];
    }

    for (int i = 0; i < [greaterArray count]; i++) {
        [sortedArray addObject:[greaterArray objectAtIndex:i]];
    }

    return sortedArray;

}


+(NSString *)convertFloatToString:(double)r
{
    return [NSString stringWithFormat:@"%f", r];
}

@end
