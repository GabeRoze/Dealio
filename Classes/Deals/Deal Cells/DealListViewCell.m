//
//  DealListViewCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-16.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealListViewCell.h"
#import "ImageCache.h"

@implementation DealListViewCell

@synthesize restaurantNameLabel;
@synthesize dealNameLabel;
@synthesize ratingLabel;
@synthesize distanceLabel;
@synthesize dealTimeLabel;
@synthesize restaurantLogoImageView;

@synthesize restaurantName;
@synthesize dealName;
@synthesize rating;
@synthesize distance;
@synthesize dealTime;
@synthesize restaurantLogo;

/*
 
 - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
 {
 self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
 if (self) {
 // Initialization code
 }
 return self;
 }
 */


-(void) createAndDisplaySpinner {
    
    if (spinner != nil) {
        [self stopSpinner];
    }
    
    // NSLog(@"spiner displayed");
    CGFloat width = restaurantLogoImageView.bounds.size.width;
    CGFloat height = restaurantLogoImageView.bounds.size.height;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(width/2.0,height/2.0)];
    [self.restaurantLogoImageView addSubview:spinner];
    [spinner startAnimating];
    //[self.view setNeedsDisplay];
    
}

-(void) stopSpinner {
    
    //NSLog(@"spinner hidden");
    
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    
}

-(void)setLogoWithString:(NSString*)str {
    
    //call get image on background
    //when returns change image on foreground
    
    //self.restaurantLogoImageView.image =  [[ImageCache sharedImageCache] getImageWithString:str];
    
    //NSLog(@"the string is : %@",str);
    
    if (str == NULL)
    {
       // NSLog(@"stringempty");        
    }
    else if ([[ImageCache sharedImageCache] checkForImage:str]) {
        
        //NSLog(@"set logo 2nd else: %@", str);
        
        self.restaurantLogoImageView.image = [[ImageCache sharedImageCache] getImage:str];
    }
    else {
        
        //show loading symbol
        //NSLog(@"image spinner!");
        [self createAndDisplaySpinner];
        //NSLog(@"initial load string: %@", str);
        [self performSelectorInBackground:@selector(loadImageWithString:) withObject:str];
        
    }
    
    
    //check if the image is in the image cache
    
    
    //[self performSelectorInBack ground:@selector(setImageFromCache:) withObject:str];
    
}


-(void)loadImageWithString:(NSString*)str {
    
    NSString* imageUrlString = [NSString stringWithFormat:@"http://www.cinnux.com/logos/%@",str];
    
    NSURL *url = [NSURL URLWithString:imageUrlString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    
    NSArray* data = [[NSArray alloc] initWithObjects:image, str, nil];
    
    
    [self performSelectorOnMainThread:@selector(setImageWithData:) withObject:data waitUntilDone:YES];
    
}

-(void)setImageWithData:(NSArray*)data {
    
    [self stopSpinner];
    
    //NSLog(@"imageWithdataarray: %@", data);
    
    
    if ([data count] > 0) {        
        
        //NSLog(@"weee this happened");
        self.restaurantLogoImageView.image = (UIImage*)[data objectAtIndex:0];
        [[ImageCache sharedImageCache] setImageWithUIImage:(UIImage*)[data objectAtIndex:0] withString:(NSString*)[data objectAtIndex:1]];
        
    }
}


/*
 
 -(void)setImageFromCache:(NSString*)str {
 
 
 NSLog(@"setImageFromCachce: %@", str);
 
 [[ImageCache sharedImageCache] getImageWithString:str];
 
 [self performSelectorOnMainThread:@selector(getImageFromCache:) withObject:str waitUntilDone:YES];
 }
 
 -(void)getImageFromCache:(NSString*)str {
 
 NSLog(@"getImageFromCachce: %@", str);
 
 
 restaurantLogoImageView.image = (UIImage*) [[ImageCache sharedImageCache] getImageWithString:str];
 
 //tell dealViewToRefreshimagess
 
 }
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setRestaurantName:(NSString*)n{
    if (![n isEqualToString:restaurantName]){
        restaurantName = [n copy];
        restaurantNameLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(84, 5, 180, 20)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:16];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor brownColor];
        label.userInteractionEnabled = NO;
        label.text= restaurantName;
        restaurantNameLabel = label;
        [self.contentView addSubview:label];
        
    }
}

-(void)setDealName:(NSString*)n{
    if (![n isEqualToString:dealName]){
        dealName = [n copy];
        dealNameLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(83, 19, 215, 35)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:24];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.userInteractionEnabled = NO;
        label.text= dealName;
        dealNameLabel = label;
        [self.contentView addSubview:label];
    }
}

-(void)setRating:(NSString*)n{
    if (![n isEqualToString:rating]){
        
        if (![n isEqualToString:@"Not enough votes"]){
            rating = [NSString stringWithFormat:@"%@%%", n];            
        }
        else {
            rating = [n copy];
        }
        
        ratingLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(83, 48, 180, 25)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:0.0f/255.0f green:146.0f/255.0f blue:137.0f/255.0f alpha:1.0f];
        label.userInteractionEnabled = NO;
        label.text= rating;
        ratingLabel = label;
        [self.contentView addSubview:label];
        
        
        
    }
}

-(void)setDistance:(NSString*)n{
    if (![n isEqualToString:distance]){
        distance = [n copy];
        //  UILabel* nameLabel = (UILabel*)[self.contentView viewWithTag:kNameValueTag];
        //distanceLabel.text = distance;
        
        distanceLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 75, 25)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:13];
        label.textAlignment = UITextAlignmentRight;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor brownColor];
        label.userInteractionEnabled = NO;
        label.text= distance;
        distanceLabel = label;
        [self.contentView addSubview:label];
        
        
        
        
    }
}


-(void)setDealTime:(NSString*)n{
    if (![n isEqualToString:dealTime]){
        dealTime = [n copy];
        //  UILabel* nameLabel = (UILabel*)[self.contentView viewWithTag:kNameValueTag];
        dealTimeLabel.text = dealTime;
    }
}
//UIImage* image = [UIImage imageNamed:@"star.png"];
//cell.imageView.image = image;

-(void) setRestaurantLogo:(UIImage *)image{
    //    restaurantLogo = image;
    //    restaurantLogoImageView = [[UIImageView alloc] initWithImage:restaurantLogo];
    // [self.contentView addSubview:restaurantLogoImageView];
    //  restaurantLogoImageView.image = restaurantLogo;
    
    
    /*
     restaurantLogo = [[UIImage alloc] initWithContentsOfFile:@"star.png"];
     restaurantLogoImageView = [[UIImageView alloc] init];
     
     restaurantLogoImageView.image = restaurantLogo;
     [self.contentView addSubview:restaurantLogoImageView];
     //[self.contentView addSubview:restaurantLogoImageView.image];
     */
}


@end
