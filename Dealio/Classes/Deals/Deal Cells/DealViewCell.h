//
//  DealViewCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-15.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewCell : UITableViewCell


@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *color;

@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UILabel* colorLabel;

@end
