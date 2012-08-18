//
//  LocationSelectionCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "LocationSelectionCell.h"

@implementation LocationSelectionCell

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LocationSelectionCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    return self;
}



@end
