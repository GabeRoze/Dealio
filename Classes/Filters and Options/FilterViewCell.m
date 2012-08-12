//
//  FilterViewCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/28/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "FilterViewCell.h"

@implementation FilterViewCell
@synthesize filterTitleLabel;
@synthesize changeFilterButton;
@synthesize filterStatus;

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

-(void) setFilterStatus:(BOOL)n {
    
    //Set filterStatus to YES (the filter is applied - check mark/minus button[to remove])
    if (n == YES) {
        [changeFilterButton setImage:[UIImage imageNamed:@"34-circle-minus.png"] forState:UIControlStateNormal];
        filterStatus = YES;
    }
    else {
        [changeFilterButton setImage:[UIImage imageNamed:@"33-circle-plus.png"] forState:UIControlStateNormal];
        filterStatus = NO;
    }
}


/*
- (IBAction)changeFilterPressed:(id)sender {
    
    //if filter == yes, remove checkmark / change button to plus
    if (filterStatus == YES ){
        [changeFilterButton setImage:[UIImage imageNamed:@"33-circle-plus.png"] forState:UIControlStateNormal];
        filterStatus = NO;
        // Send notification to FilterViewController that a filter has been removed

    }
    else {
        [changeFilterButton setImage:[UIImage imageNamed:@"34-circle-minus.png"] forState:UIControlStateNormal];
        filterStatus = NO;

    }
    
    
}
 */


@end
