//
//  SideBySideTextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "SideBySideTextFieldCell.h"

@implementation SideBySideTextFieldCell
@synthesize leftTextField;
@synthesize rightTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideBySideTextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
    
    return self;
}

@end
