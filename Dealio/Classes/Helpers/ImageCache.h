//
//  ImageCache.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/7/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject


@property (strong, nonatomic) NSMutableArray* imageArray;
@property (strong, nonatomic) NSMutableDictionary* imageDictionary;
@property (assign, nonatomic) int arrayCount;


//-(UIImage*)setImageWithString:(NSString*)str;
//-(UIImage*)getImageWithString:(NSString*)str;

+(ImageCache*) sharedImageCache;
-(void)setImageWithUIImage:(UIImage*)image withString:(NSString*)str;
-(BOOL) checkForImage:(NSString*)str;
-(UIImage*)getImage:(NSString*)str;

@end
