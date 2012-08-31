//
//  ButtonCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-31.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell
@synthesize buttonLabel;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ButtonCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    
       backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]]; 
    
    return self;
}

@end
