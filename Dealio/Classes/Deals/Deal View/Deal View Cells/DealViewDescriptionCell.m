//
//  DealViewDescriptionCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealViewDescriptionCell.h"

@implementation DealViewDescriptionCell
@synthesize backgroundImage;
@synthesize descriptionTextView;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealViewDescriptionCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];
    
    return self;
}

@end
