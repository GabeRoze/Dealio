//
//  FilterViewCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/28/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *filterTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeFilterButton;
@property (assign, nonatomic) BOOL filterStatus;

@end
