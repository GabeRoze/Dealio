//
//  UserManager.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/27/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject


@property (copy, nonatomic) NSString* email;
@property (copy, nonatomic) NSString* password;
@property (copy, nonatomic) NSString* firstName;
@property (copy, nonatomic) NSString* lastName;
@property (assign, nonatomic) BOOL userIsLoggedIn;

@property (strong, nonatomic) NSMutableDictionary* cuisineOptions;
@property (strong, nonatomic) NSMutableDictionary* priceOptions;
@property (assign, nonatomic) NSInteger* maxDistanceOption;

@property (strong, nonatomic) NSMutableArray* cuisineTypes;

@property (strong, nonatomic) NSString* userSettingsPath;
@property (strong, nonatomic) NSString* cuisineFilteresPath;
@property (strong, nonatomic) NSString* priceFiltersPath;

-(void) resetManager;
-(void)setCuisineOption:(NSString*)optionName toState:(NSString*)state;
-(void)setPriceOption:(NSString*)optionName toState:(NSString*)state;

-(NSString*) getPriceOption:(NSString*)optionName;
-(NSString*) getCuisineOption:(NSString*)optionName;

+(UserManager*) sharedManager;


-(void) resetFilters;


-(NSString*) getPath:(NSString*)filename;

-(void) saveData;



@end
