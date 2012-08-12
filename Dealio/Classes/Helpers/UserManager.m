//
//  UserManager.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/27/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "userManager.h"

@implementation UserManager

@synthesize email;
@synthesize password;
@synthesize firstName;
@synthesize lastName;
@synthesize userIsLoggedIn;

@synthesize cuisineOptions;
@synthesize priceOptions;
@synthesize maxDistanceOption;
@synthesize cuisineTypes;


@synthesize userSettingsPath;
@synthesize cuisineFilteresPath;
@synthesize priceFiltersPath;

static UserManager *userManagerInstance;




-(id) init
{
    if ((self = [super init]))
    {        
        
        NSAssert(userManagerInstance == nil, @"another UserManager is already in use!");
        userManagerInstance = self;
        
        
        /*
        NSError* error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"PriceFilters.plist"]; //3
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]) //4
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"PriceFilters" ofType:@"plist"]; //5
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        }
        
         */

        priceFiltersPath = [self getPath:@"PriceFilters"];
        cuisineFilteresPath = [self getPath:@"CuisineFilters"];

        
        self.priceOptions = [[NSMutableDictionary alloc] initWithContentsOfFile:priceFiltersPath];
        self.cuisineOptions = [[NSMutableDictionary alloc] initWithContentsOfFile:cuisineFilteresPath];
        
        //priceFiltersPath = [path copy];
        //NSLog(@"first: %@",self.priceOptions);

        //priceFiltersPath = [[NSBundle mainBundle] pathForResource:@"PriceFilters" ofType:@"plist"];
        //cuisineFilteresPath = [[NSBundle mainBundle] pathForResource:@"CuisineFilters" ofType:@"plist"];
        
        
        //priceOptions =[[NSMutableDictionary alloc] initWithContentsOfFile:priceFiltersPath];
        //cuisineOptions = [[NSMutableDictionary alloc] initWithContentsOfFile:cuisineFilteresPath];
       

        
        
        //cuisineTypes = [[NSMutableArray alloc] initWithObjects:@"American", @"Cafe", @"Chinese", @"Korean", @"Bar/Alcohol", @"Dessert", @"Fast Food", @"French", @"Indian", @"Italian", @"Japanese", @"Vietnamese/Thai", @"Greek", @"International", @"Vegetarian", nil];
        
        // priceOptions = [[NSMutableDictionary alloc] initWithObjectsAndKeys: @"YES", @"$", @"YES", @"$$", @"YES", @"$$$", nil];
        
        
        // NSMutableArray* initOptions = [[NSMutableArray alloc] init];
        
        // for (int i = 0; i < [cuisineTypes count] ; i++) {
        //      [initOptions insertObject:@"YES" atIndex:i];  
        //   }
        //   
        //    cuisineOptions = [[NSMutableDictionary alloc] initWithObjects:initOptions forKeys:cuisineTypes];
        
        
        // NSLog(@"%@", (NSString*)[cuisineOptions objectForKey:@"American (Traditional)"]);
        /// NSLog(@"%@", (NSString*)[cuisineOptions objectForKey:@"Dessert"]);
        
        
        //        cuisineOptions = [[NSDictionary alloc] initWithObjectsAndKeys:@"YES", @"American (Traditional)"
        
        
        //      * row1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"McDonalds", @"restaurantName", @"Free Burgers", @"dealName", @"124 Likes", @"rating", @"300m", @"distance", @"12pm - 6pm", @"dealTime", nil];
        
        
    }
    return self;
}

-(NSString*) getPath:(NSString*)filename {
    
    NSError *error;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* priceOptionsDirectory = [paths objectAtIndex:0];
    
    NSString* temp = [filename copy];
    temp = [temp stringByAppendingString:@".plist"];
    //NSLog(@"temp is:%@",temp);
    NSString* thePath = [priceOptionsDirectory stringByAppendingPathComponent:temp];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if ( ![fileManager fileExistsAtPath:thePath]) {
        NSString* bundle = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:thePath error:&error];
    }
    
    
    
    return thePath;
}


+(UserManager*) sharedManager
{
    NSAssert(userManagerInstance != nil, @"UserManager not available!");
    return userManagerInstance;
}


-(void) resetManager {
    userManagerInstance=nil;
}




-(void)setEmail:(NSString*)n{
    if (![n isEqualToString:email]){
        email = [n copy];
        //perform plist write
    }
}

-(void)setPassword:(NSString *)n {
    if (![n isEqualToString:password]){
        password = [n copy];
    }
}

-(void)setFirstName:(NSString*)n{
    if (![n isEqualToString:firstName]){
        firstName = [n copy];
    }
}

-(void)setLastName:(NSString*)n{
    if (![n isEqualToString:lastName]){
        lastName = [n copy];
    }
}

-(void)setCuisineOption:(NSString*)optionName toState:(NSString*)state {
   
    
    
    
    NSString* key = [optionName copy];
    NSString* object = [state copy];
    
    [cuisineOptions setObject:object forKey:key];
    
    
    //[cuisineOptions setObject:state forKey:optionName];
    
    //perform plist write
}

-(NSString*) getCuisineOption:(NSString*)optionName {
    return (NSString*)[cuisineOptions objectForKey:optionName];
}


-(void)setPriceOption:(NSString*)optionName toState:(NSString*)state {
    
    
    //NSLog(@"before change: %@",self.priceOptions);
    
    NSString* key = [optionName copy];
    NSString* object = [state copy];

    [priceOptions setObject:object forKey:key];
    
    
    /*
    NSLog(@"after change: %@",self.priceOptions);
    
    
    if ([self.priceOptions writeToFile:self.priceFiltersPath atomically:YES]){
        NSLog(@"it worked!");
    }
    else {
        NSLog(@"didnt work :(");
    }    
      
    
    
    self.priceOptions = nil;
    self.priceOptions =[[NSMutableDictionary alloc] initWithContentsOfFile:self.priceFiltersPath];
    NSLog(@"updated: %@",self.priceOptions);
     
     */
    
    
}

-(NSString*) getPriceOption:(NSString*)optionName {
    return (NSString*)[priceOptions objectForKey:optionName];
}


-(void) saveData {
    
    //NSLog(@"save data: %@",self.priceOptions);

    [self.priceOptions writeToFile:self.priceFiltersPath atomically:YES];
    [self.cuisineOptions writeToFile:self.cuisineFilteresPath atomically:YES];
}


-(void) resetFilters {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init ];
    for (id key in priceOptions) {
        //[priceOptions setObject:@"YES" forKey:(NSString*)key];
        //[dict setValue:@"YES" forUndefinedKey:(NSString*)key];
        [dict setObject:@"YES" forKey:(NSString*)key];
    }
    
    priceOptions = dict;
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init ];
    
    for (id key in cuisineOptions) {
        //[cuisineOptions setObject:@"YES" forKey:(NSString*)key];
        [dict2 setObject:@"YES" forKey:(NSString*)key];
        
    }
    
    cuisineOptions = dict2;
    
    //write both dictionaries to plist
}


@end
