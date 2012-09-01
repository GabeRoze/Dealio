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


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealListViewCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

//    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    [dealNameLabel setFont:[UIFont fontWithName:@"Rokkitt" size:dealNameLabel.font.pointSize]];

    return self;
}

-(void) createAndDisplaySpinner
{
    if (spinner)//if (spinner != nil)
    {
        [self stopSpinner];
    }
    CGFloat width = restaurantLogoImageView.bounds.size.width;
    CGFloat height = restaurantLogoImageView.bounds.size.height;

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(width/2.0,height/2.0)];
    [self.restaurantLogoImageView addSubview:spinner];
    [spinner startAnimating];
}

-(void) stopSpinner
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
}

-(void)setLogoWithString:(NSString*)str
{
    if (!str)
    {
        NSLog(@"no logo value");
    }
    else if ([[ImageCache sharedImageCache] checkForImage:str])
    {
        self.restaurantLogoImageView.image = [[ImageCache sharedImageCache] getImage:str];
    }
    else
    {
        [self createAndDisplaySpinner];
        [self performSelectorInBackground:@selector(loadImageWithString:) withObject:str];
    }
}

-(void)loadImageWithString:(NSString*)str
{
    NSString* imageUrlString = [NSString stringWithFormat:@"http://www.dealio.cinnux.com/wp-content/uploads/%@",str];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    NSArray* data = [[NSArray alloc] initWithObjects:image, str, nil];
    [self performSelectorOnMainThread:@selector(setImageWithData:) withObject:data waitUntilDone:YES];
}

-(void)setImageWithData:(NSArray*)data
{
    [self stopSpinner];
    if ([data count] > 0)
    {
        self.restaurantLogoImageView.image = (UIImage*)[data objectAtIndex:0];
        [[ImageCache sharedImageCache] setImageWithUIImage:(UIImage*)[data objectAtIndex:0] withString:(NSString*)[data objectAtIndex:1]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setRestaurantName:(NSString*)n
{
    if (![n isEqualToString:restaurantName])
    {
        restaurantName = [n copy];
        restaurantNameLabel.text = restaurantName;
    }
}

-(void)setDealName:(NSString*)n
{
    if (![n isEqualToString:dealName])
    {
        dealName = [n copy];
        dealNameLabel.text = dealName;
    }
}

-(void)setRating:(NSString*)n
{
    if (![n isEqualToString:rating])
    {
        rating = [n copy];
        ratingLabel.text = rating;
    }
}

-(void)setDistance:(NSString*)n
{
    if (![n isEqualToString:distance])
    {
        distance = [n copy];
        distanceLabel.text = distance;
    }
}

-(void)setDealTime:(NSString*)n
{
    if (![n isEqualToString:dealTime])
    {
        dealTime = [n copy];
        dealTimeLabel.text = dealTime;
    }
}

@end
