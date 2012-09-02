//
//  SideBySideTextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "SideBySideTextFieldCell.h"
#import "Models.h"

@implementation SideBySideTextFieldCell
@synthesize leftTextField;
@synthesize rightTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SideBySideTextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];

    return self;
}

- (IBAction)firstNameDidEndOnExit:(id)sender
{
    [RegistrationData instance].firstName = leftTextField.text;
}

- (IBAction)lastNameDidEndOnExit:(id)sender
{
    [RegistrationData instance].lastName = rightTextField.text;
}

- (IBAction)firstNameEditingChanged:(id)sender
{
    [RegistrationData instance].firstName = leftTextField.text;
}

- (IBAction)lastNameEditingChanged:(id)sender
{
    [RegistrationData instance].lastName = rightTextField.text;
}
@end
