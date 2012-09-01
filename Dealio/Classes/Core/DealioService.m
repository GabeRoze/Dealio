//
//  DealioService.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealioService.h"
#import "CalculationHelper.h"

@implementation DealioService

//copy deallistweb connectivity code to here
//add a parameter with a block
//block will set the data
//

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
//                          NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                          NSLog (@"HTML = %@", html);
                          success(data);
                      }
                      else
                      {
                          failure();
                      }
                  }];
}



@end
