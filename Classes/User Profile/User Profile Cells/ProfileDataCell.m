//
//  ProfileDataCell.m
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileDataCell.h"

@implementation ProfileDataCell

@synthesize textLabel;
@synthesize leftImage;


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileDataCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    return self;
}

@end
