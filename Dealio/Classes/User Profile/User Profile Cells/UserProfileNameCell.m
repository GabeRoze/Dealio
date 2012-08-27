//
//  UserProfileNameCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "UserProfileNameCell.h"

@implementation UserProfileNameCell
@synthesize nameLabel;
@synthesize emailLabel;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserProfileNameCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];

    return self;
}

@end
