//
//  UpdateButtonCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "UpdateButtonCell.h"

@implementation UpdateButtonCell


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UpdateButtonCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}

- (IBAction)updateButtonTapped:(id)sender
{
    //convert saved address into coordinate
    //update savedcoordinate
    //save nsuerdefaults
    //open table and reload data for currently selected day


}
@end
