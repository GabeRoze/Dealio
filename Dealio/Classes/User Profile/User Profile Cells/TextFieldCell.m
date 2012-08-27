//
//  TextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize passwordTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    
//    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
    
    return self;
}

@end
