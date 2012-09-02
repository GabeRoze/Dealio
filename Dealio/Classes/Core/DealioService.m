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

@implementation DealioService

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
                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          failure();
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
                          failure();
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
                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          failure();
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
                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          failure();
                      }
                  }];

}

@end
