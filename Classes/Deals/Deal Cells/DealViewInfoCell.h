//
//  DealViewInfoCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-18.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewInfoCell : UITableViewCell


@property (copy, nonatomic) NSString *rating;
@property (copy, nonatomic) NSString *dealDays;
@property (copy, nonatomic) NSString *dealTime;


@property (strong, nonatomic) IBOutlet UILabel* ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel* dealDaysLabel;
@property (strong, nonatomic) IBOutlet UILabel* dealTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
