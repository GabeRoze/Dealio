//
//  DealioService.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealioService.h"
#import "CalculationHelper.h"
#import "Models.h"
#import "GRCustomSpinnerView.h"
#import "AlertHelper.h"

@implementation DealioService

+(void)submitComment:(NSString *)comment uid:(NSString *)uid onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    NSString *command1 = @"cmd=submitcomment";
    NSString* command2 = [NSString stringWithFormat:@"&cmd2=%@",comment];
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
    NSString* uidString = [NSString stringWithFormat:@"&uid=%@",uid];
    NSString* userFirstName = [NSString stringWithFormat:@"&userfirstname=%@",UserData.instance.firstName];
    NSString* userLastName = [NSString stringWithFormat:@"&userlastname=%@",UserData.instance.lastName];
    NSString* urlAsString = [NSString stringWithFormat:@"%@%@%@%@%@%@",command1, command2, emailString, uidString, userFirstName ,userLastName];
    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                               queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error)
                  {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
                          NSLog (@"Comment Response HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)getFavoriteListForDay:(NSString *)day onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    CLLocationCoordinate2D coordinate = SearchLocation.instance.getLocation;
    NSString* currentDay = [NSString stringWithFormat:@"currentday=%@",day];
    NSString *latitude = [NSString stringWithFormat:@"&userlat=%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"&userlong=%f", coordinate.longitude];
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
//    NSString* maxDistance = [NSString stringWithFormat:@"&maxdistance=%i", FilterData.instance.maximumSearchDistance];
    NSString* urlAsString = [NSString stringWithFormat:@"%@%@%@%@",currentDay, latitude, longitude, emailString];

    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newfavoritedealheader-func.php/";
    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                               queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error)
                  {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
                          NSLog (@"Favorite List Response HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)getDealListForDay:(NSString *)day onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    CLLocationCoordinate2D coordinate = SearchLocation.instance.getLocation;
    NSString* currentDay = [NSString stringWithFormat:@"currentday=%@",day];
    NSString *latitude = [NSString stringWithFormat:@"&userlat=%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"&userlong=%f", coordinate.longitude];
    NSString* maxDistance = [NSString stringWithFormat:@"&maxdistance=%i", FilterData.instance.maximumSearchDistance];
    NSString* urlAsString = [NSString stringWithFormat:@"%@%@%@%@",currentDay, latitude, longitude, maxDistance];

    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newdealheader-func.php/";
    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlAsString];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error)
                  {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
//                          NSLog (@"Deal Like Response HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)updateLikedForUID:(NSString *)uid onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSString *command1 = @"cmd=submitlike";
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
    NSString* uidString = [NSString stringWithFormat:@"&uid=%@",uid];


    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", command1, emailString, uidString];
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
//                          NSLog (@"Deal Like Response HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)updateFavoritedForUID:(NSString *)uid command:(NSString *)command onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    NSString *command1 = @"cmd=updatefav";
    NSString* command2 = [NSString stringWithFormat:@"&cmd2=%@",command];
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
    NSString* uidString = [NSString stringWithFormat:@"&uid=%@",uid];


    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", command1, command2, emailString, uidString];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
//                          NSLog (@"Deal Info HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)getDealWithUID:(NSString *)uid onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    NSString* functionURL = @"http://www.dealio.cinnux.com/app/newdealdetail-func.php/";

    NSString* uidString = [NSString stringWithFormat:@"uid=%@",uid ];
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@", UserData.instance.email];
    NSString *urlData = [NSString stringWithFormat:@"%@%@", uidString, emailString];
    NSMutableURLRequest* urlRequest = [CalculationHelper getURLRequest:functionURL withData:urlData];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {

                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc]
                                  initWithData:data
                                      encoding:NSUTF8StringEncoding];
                          NSLog (@"Deal Info HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)loginWithEmail:(NSString *)email password:(NSString *)password onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure
{
    NSString *command = @"cmd=login";
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",email];
    NSString* passwordString = [NSString stringWithFormat:@"&userpw=%@",password];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", command,emailString,passwordString];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)getUserProfileWithSuccess:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure
{
    NSString *command = @"cmd=profileretrieve";
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", command,emailString];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}


+(void)changePasswordWithNewPassword:(NSString *)newPassword currentPassword:(NSString *)currentPassword onSuccess:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure
{
    NSString *command = @"cmd=changepw";
    NSString *command2 = [NSString stringWithFormat:@"&cmd2=%@", newPassword];
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",UserData.instance.email];
    NSString *curPassword = [NSString stringWithFormat:@"&userpw=%@", currentPassword];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", command, command2, emailString, curPassword];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)forgotPassword:(NSString *)email onSuccess:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure
{
    NSString *command = @"cmd=forgotpw";
    NSString* emailString = [NSString stringWithFormat:@"&useremail=%@",email];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", command, emailString];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                          NSLog (@"Forgot PW HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)registerUser:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure
{
    RegistrationData *registrationData = RegistrationData.instance;
    NSString *command = @"cmd=register";
    NSString* userEmail = [NSString stringWithFormat:@"&useremail=%@",registrationData.email];
    NSString* userPassword = [NSString stringWithFormat:@"&userpw=%@",registrationData.password];
    NSString* userFirstName = [NSString stringWithFormat:@"&userfirstname=%@",registrationData.firstName];
    NSString* userLastName = [NSString stringWithFormat:@"&userlastname=%@",registrationData.lastName];
    NSString* gender = [NSString stringWithFormat:@"&gender=%@",registrationData.sex];
    NSString* foodDescription = [NSString stringWithFormat:@"&fooddescription=%@",registrationData.foodDescription];
    NSString* age = [NSString stringWithFormat:@"&age=%i",registrationData.age];
    NSString* ethnicity = [NSString stringWithFormat:@"&ethnicity=%i",registrationData.ethnicity];
    NSString* income = [NSString stringWithFormat:@"&income=%i",registrationData.income];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@", command, userEmail, userPassword, userFirstName, userLastName, gender, foodDescription, age, ethnicity, income];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}

+(void)sendTip:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure
{
    TipUsData *tipUsData = TipUsData.instance;
    NSString *command = @"cmd=tip";
    NSString* businessName = [NSString stringWithFormat:@"&businessname=%@",tipUsData.businessName];
    NSString* dealName = [NSString stringWithFormat:@"&dealname=%@",tipUsData.dealName];
    NSString* detail = [NSString stringWithFormat:@"&detail=%@",tipUsData.detail];
    NSString* address = [NSString stringWithFormat:@"&address=%@",tipUsData.address];
    NSString* latitude = [NSString stringWithFormat:@"&latitude=%@",tipUsData.latitude];
    NSString* longitude = [NSString stringWithFormat:@"&longitude=%@",tipUsData.longitude];
    NSString* sunday = [NSString stringWithFormat:@"&sun=%@", [tipUsData.days objectAtIndex:0]];
    NSString* monday = [NSString stringWithFormat:@"&mon=%@", [tipUsData.days objectAtIndex:1]];
    NSString* tuesday = [NSString stringWithFormat:@"&tue=%@", [tipUsData.days objectAtIndex:2]];
    NSString* wednesday = [NSString stringWithFormat:@"&wed=%@", [tipUsData.days objectAtIndex:3]];
    NSString* thursday = [NSString stringWithFormat:@"&thu=%@", [tipUsData.days objectAtIndex:4]];
    NSString* friday = [NSString stringWithFormat:@"&fri=%@", [tipUsData.days objectAtIndex:5]];
    NSString* saturday = [NSString stringWithFormat:@"&sat=%@", [tipUsData.days objectAtIndex:6]];
    NSString* openTime = [NSString stringWithFormat:@"&open=%i",tipUsData.openTime];
    NSString* closeTime = [NSString stringWithFormat:@"&open=%i",tipUsData.closeTime];

    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",
                                                     command,
                                                     businessName,
                                                     dealName,
                                                     detail,
                                                     address,
                                                     latitude,
                                                     longitude,
                                                     sunday,
                                                     monday,
                                                     tuesday,
                                                     wednesday,
                                                     thursday,
                                                     friday,
                                                     saturday,
                                                     sunday,
                                                     openTime,
                                                     closeTime];
    NSString* functionUrl = @"http://dealio.cinnux.com/app/newuserstart-func.php/";
    NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlString];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
            sendAsynchronousRequest:urlRequest
                              queue:queue
                  completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
                      if ([data length] > 0 && error == nil)
                      {
                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
//                          failure();
                          [self webConnectionFailed];
                      }
                  }];
}


+(void)webConnectionFailed
{
    [GRCustomSpinnerView.instance stopSpinner];
    [AlertHelper displayWebConnectionFail];
}

@end
