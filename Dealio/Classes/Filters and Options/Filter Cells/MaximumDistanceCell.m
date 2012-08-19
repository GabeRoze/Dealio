//
//  MaximumDistanceCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "MaximumDistanceCell.h"

@implementation MaximumDistanceCell
@synthesize maxKmLabel;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MaximumDistanceCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}


@end
