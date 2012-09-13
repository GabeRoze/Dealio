//
//  DealListViewCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-16.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealListViewCell : UITableViewCell
{
    UIActivityIndicatorView* spinner;

    IBOutlet UIImageView *backgroundImage;
}

@property (copy, nonatomic) NSString *restaurantName;
@property (copy, nonatomic) NSString *dealName;
@property (copy, nonatomic) NSString *rating;
@property (copy, nonatomic) NSString *distance;
@property (copy, nonatomic) NSString *dealTime;
@property (strong, nonatomic) UIImage *restaurantLogo;

@property (strong, nonatomic) IBOutlet UILabel* restaurantNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* dealNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel* distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel* dealTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *restaurantLogoImageView;
@property (strong, nonatomic) IBOutlet UILabel *featuredLabel;


-(void)setLogoWithString:(NSString*)str;
-(void)loadImageWithString:(NSString*)str;
-(void)setImageWithData:(NSArray*)data;

-(void) createAndDisplaySpinner;
-(void) stopSpinner;
-(void)setFeaturedBackground;
-(void)setBackgroundWithPattern;

@end
