//
//  SelectDayCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "SelectDayCell.h"

@implementation SelectDayCell

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SelectDayCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];
    [self initCheckboxButtons];

    return self;
}

-(void)initCheckboxButtons
{
    buttonArray = [[NSArray alloc] initWithObjects:button1,button2,button3,button4,button5,button6,button7,nil];

    for (UIImageView *image in buttonArray)
    {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBoxButtonTapped:)];
        [image addGestureRecognizer:tapGestureRecognizer];
    }
}

-(IBAction)checkBoxButtonTapped:(id)sender
{
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIImageView *button = (UIImageView *) tapGestureRecognizer.view;
    button.highlighted = !button.highlighted;
}

@end
