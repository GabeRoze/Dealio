//
//  PickerDisplayCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "PickerDisplayCell.h"
#import "ActionSheetPicker.h"

@implementation PickerDisplayCell
@synthesize descriptionLabel;
@synthesize timeLabel;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PickerDisplayCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    return self;
}


@end
