//
//  AlertHelper.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-02.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertHelper : NSObject

+(void)displayAlertWithOKButtonUsingTitle:(NSString *)title andAction:(void (^)())action;
+(void)displayAlertWithOKButtonUsingTitle:(NSString *)title withMessage:(NSString *)message andAction:(void (^)())action;
+(void)displayWebConnectionFail;

@end
