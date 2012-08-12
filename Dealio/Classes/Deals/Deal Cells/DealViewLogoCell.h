//
//  DealViewLogoCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-16.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewLogoCell : UITableViewCell {
    UIActivityIndicatorView* spinner;
}

@property (copy, nonatomic) NSString *restaurantName;
@property (copy, nonatomic) NSString *dealName;
@property (copy, nonatomic) UIImage *restaurantLogo;

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *daysAvailableLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)setLogoWithString:(NSString*)str;
-(void)loadImageWithString:(NSString*)str;
-(void)setImageWithData:(NSArray*)data;

-(void) createAndDisplaySpinner; 
-(void) stopSpinner;



@end
