//
//  DealViewInfoCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-18.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewInfoCell.h"

@implementation DealViewInfoCell



@synthesize rating;
@synthesize dealDays;
@synthesize dealTime;

@synthesize ratingLabel;
@synthesize dealDaysLabel;
@synthesize dealTimeLabel;
@synthesize backgroundImage;


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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setRating:(NSString*)n{
    if (![n isEqualToString:rating]){
        rating = [n copy];
        ratingLabel.text = rating;
    }
}

-(void)setDealDays:(NSString*)n{
    if (![n isEqualToString:dealDays]){
        dealDays = [n copy];
        dealDaysLabel.text = dealDays;
    }
}


-(void)setDealTime:(NSString*)n{
    if (![n isEqualToString:dealTime]){
        dealTime = [n copy];
        dealTimeLabel.text = dealTime;
    }
}

@end
