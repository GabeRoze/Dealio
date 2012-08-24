//
//  ContactInfoCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-24.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "ContactInfoCell.h"

@implementation ContactInfoCell

@synthesize leftImageView;
@synthesize contactLabel;
@synthesize contactType;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactInfoCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    [backgroundImage addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(IBAction)cellTapped:(id)sender
{
    if (contactType == phone)
    {
        //todo - dial phone
        NSLog(@"Dial %@", contactLabel.text);
    }
    else if (contactType == website)
    {
        NSLog(@"Open %@", contactLabel.text);
        //todo - open website
    }
    else if (contactType == address)
    {
        NSLog(@"Direct to %@", contactLabel.text);
        //todo open directions to address
    }
}

@end
