//
//  TextFieldCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "TextFieldCell.h"
#import "Models.h"

@implementation TextFieldCell

@synthesize cellTextField;
@synthesize backgroundImage;
@synthesize cellType;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    return self;
}

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    if (cellType == EmailCell)
    {
        RegistrationData.instance.email = cellTextField.text;
    }
    else if (cellType == PasswordCell)
    {
        RegistrationData.instance.password = cellTextField.text;
    }
    else if (cellType == FoodDescriptionCell)
    {
        RegistrationData.instance.foodDescription = cellTextField.text;
    }
    else if (cellType == RestaurantNameCell)
    {
        TipUsData.instance.businessName = cellTextField.text;
    }
    else if (cellType == DealNameCell)
    {
        TipUsData.instance.dealName = cellTextField.text;
    }
    else if (cellType == DealDetailCell)
    {
        TipUsData.instance.detail = cellTextField.text;
    }
}

- (IBAction)textFieldEditingChanged:(id)sender
{
    if (cellType == EmailCell)
    {
        RegistrationData.instance.email = cellTextField.text;
    }
    else if (cellType == PasswordCell)
    {
        RegistrationData.instance.password = cellTextField.text;
    }
    else if (cellType == FoodDescriptionCell)
    {
        RegistrationData.instance.foodDescription = cellTextField.text;
    }
    else if (cellType == RestaurantNameCell)
    {
        TipUsData.instance.businessName = cellTextField.text;
    }
    else if (cellType == DealNameCell)
    {
        TipUsData.instance.dealName = cellTextField.text;
    }
    else if (cellType == DealDetailCell)
    {
        TipUsData.instance.detail = cellTextField.text;
    }
}

@end

