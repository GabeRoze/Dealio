//
//  ImageCache.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/7/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "ImageCache.h"

@implementation ImageCache

@synthesize imageArray;
@synthesize imageDictionary;
@synthesize arrayCount;


static ImageCache* imageCacheInstance;

-(id) init
{
    if ((self = [super init]))
    {  
        NSAssert(imageCacheInstance == nil, @"another image cache is in use!");
        imageCacheInstance = self;
        imageArray = [[NSMutableArray alloc] init];
        imageDictionary = [[NSMutableDictionary alloc] init];
        arrayCount = 0;
        
    }
    
    return self;
    
}


-(UIImage*)setImageWithString:(NSString *)str {
    
    //if the image dictionary does not contain the string
    //meaning the image has not been loaded
   
    if ([imageDictionary objectForKey:str] == nil ) {
    
        //the object is the array position
        //the key is the variable name
        NSString* arrayCountAsString = [NSString stringWithFormat:@"%i", arrayCount];
        [imageDictionary setObject:arrayCountAsString forKey:str];
        
        
        
        //get image from server
         NSString* imageUrlString = [NSString stringWithFormat:@"http://www.cinnux.com/logos/%@",str];
         
         NSURL *url = [NSURL URLWithString:imageUrlString];
         UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
         
        
        //add object to array
        NSLog(@"array count: %i", arrayCount);
        NSLog(@"image dictionary: %@",imageDictionary);
        [imageArray insertObject:image atIndex:arrayCount];
        arrayCount++;
        return image;
    }
    
    else {
        return (UIImage*) [imageArray objectAtIndex:(int)[imageDictionary objectForKey:str]];
    }
    
    
    
}


-(void)setImageWithUIImage:(UIImage*)image withString:(NSString*)str {
    [imageDictionary setObject:image forKey:str];
}

-(BOOL) checkForImage:(NSString*)str {

    if ([imageDictionary objectForKey:str]) {
        return YES;    
    }
    else {
        return NO;
    }
    
}

-(UIImage*)getImage:(NSString*)str {
    
    return (UIImage*)[imageDictionary objectForKey:str];
}


/*
 
 perform selector in background
 when loaded call image loaded
 
 */


-(UIImage*)getImageWithString:(NSString *)str {
   
   
    if ([imageDictionary objectForKey:str] != nil) {
        
        
        NSLog(@"imagedictionary for key: %@",[imageDictionary objectForKey:str]);
        
        int imageLocation = [[imageDictionary objectForKey:str] intValue];
        
        
        return (UIImage*) [imageArray objectAtIndex:imageLocation];
        
    }
    else {
    
        //return default image
        return nil;
        
    }

    NSLog(@"nil returned");
    return nil;

}

+(ImageCache*) sharedImageCache {
    
    NSAssert(imageCacheInstance != nil, @"UserManager not available!");
    return imageCacheInstance;
}


@end
