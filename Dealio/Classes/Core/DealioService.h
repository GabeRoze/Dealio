//
//  DealioService.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealioService : NSObject

+(void)updateLikedForUID:(NSString *)uid onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure;
+(void)updateFavoritedForUID:(NSString *)uid command:(NSString *)command onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure;
+(void)getDealWithUID:(NSString *)uid onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure;
+(void)loginWithEmail:(NSString *)email password:(NSString *)password onSuccess:(void (^)(NSData *xmlData))success onFailure:(void (^)())failure;
+(void)getUserProfileWithSuccess:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure;
+(void)changePasswordWithNewPassword:(NSString *)newPassword currentPassword:(NSString *)currentPassword onSuccess:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure;
+(void)registerUser:(void (^)(NSData *xmlData))success andFailure:(void (^)())failure;
+(void)webConnectionFailed;

@end
