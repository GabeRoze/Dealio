//
//  DealViewLogoCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-16.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewLogoCell.h"
#import "ImageCache.h"

@implementation DealViewLogoCell

@synthesize restaurantNameLabel;
@synthesize dealNameLabel;
@synthesize restaurantLogoImageView;
@synthesize daysAvailableLabel;
@synthesize timeLabel;

@synthesize restaurantName;
@synthesize dealName;
@synthesize restaurantLogo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setRestaurantName:(NSString*)n{
    if (![n isEqualToString:restaurantName]){
        restaurantName = [n copy];
        //  UILabel* nameLabel = (UILabel*)[self.contentView viewWithTag:kNameValueTag];
        restaurantNameLabel.text = restaurantName;
    }
}

-(void)setDealName:(NSString*)n{
    if (![n isEqualToString:dealName]){
        dealName = [n copy];
        //  UILabel* nameLabel = (UILabel*)[self.contentView viewWithTag:kNameValueTag];
        dealNameLabel.text = dealName;
    }
}



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

    if ([[ImageCache sharedImageCache] checkForImage:str]) {

        //NSLog(@"setLogoWithString: %@", str);

        self.restaurantLogoImageView.image = [[ImageCache sharedImageCache] getImage:str];
    }
    else {

        //show loading symbol
        //NSLog(@"image spinner!");
        [self createAndDisplaySpinner];

        [self performSelectorInBackground:@selector(loadImageWithString:) withObject:str];

    }


    //check if the image is in the image cache


    //[self performSelectorInBack ground:@selector(setImageFromCache:) withObject:str];

}


-(void)loadImageWithString:(NSString*)str {

    NSString* imageUrlString = [NSString stringWithFormat:@"http://www.dealio.cinnux.com/app/%@",str];

    NSURL *url = [NSURL URLWithString:imageUrlString];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];


    NSArray* data = [[NSArray alloc] initWithObjects:image, str, nil];


    [self performSelectorOnMainThread:@selector(setImageWithData:) withObject:data waitUntilDone:YES];

}

-(void)setImageWithData:(NSArray*)data {

    [self stopSpinner];

    //NSLog(@"imageWithdataarray: %@", data);


    if ([data count] > 0) {

        self.restaurantLogoImageView.image = (UIImage*)[data objectAtIndex:0];
        [[ImageCache sharedImageCache] setImageWithUIImage:(UIImage*)[data objectAtIndex:0] withString:(NSString*)[data objectAtIndex:1]];

    }
}


@end
