//
//  AdressTextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-19.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "AddressTextFieldCell.h"

@implementation AddressTextFieldCell
@synthesize addressTextField;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}

- (IBAction)addressTextFieldDonePressed:(id)sender
{
    [self saveAddressToDefaults];
}

- (IBAction)addressTextFieldChanged:(id)sender
{
    [self saveAddressToDefaults];
}

-(void)saveAddressToDefaults
{
    [NSUserDefaults.standardUserDefaults setObject:addressTextField.text forKey:@"savedAddress"];
    SearchLocation.instance.savedAddressString = addressTextField.text;
}
@end
