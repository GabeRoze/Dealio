//
//  MaleFemaleSelectionCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "MaleFemaleSelectionCell.h"

@implementation MaleFemaleSelectionCell


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MaleFemaleSelectionCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    return self;
}

@end
