//
//  TableHeaderCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "TableHeaderCell.h"

@implementation TableHeaderCell
@synthesize headerLabel;
@synthesize headerLeftImage;
@synthesize headerBackgroundImage;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableHeaderCell" owner:self options:nil];

    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    [headerLabel setFont:[UIFont fontWithName:@"Rokkitt" size:30]];

    return self;
}

@end
