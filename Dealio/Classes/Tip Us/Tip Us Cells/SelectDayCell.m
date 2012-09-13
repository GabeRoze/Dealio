//
//  SelectDayCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "SelectDayCell.h"
#import "Models.h"

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

    if (button.highlighted)
    {
        [TipUsData.instance.days insertObject:@"1" atIndex:button.tag];
    }
    else
    {
        [TipUsData.instance.days insertObject:@"0" atIndex:button.tag];
    }
}

-(void)setSelectedDaysFromMemory
{
    for (NSUInteger i = 0; i < buttonArray.count; i++)
    {
        NSString *selected = [TipUsData.instance.days objectAtIndex:i];
        UIImageView *image = (UIImageView *)[buttonArray objectAtIndex:i];
        if ([selected isEqualToString:@"1"])
        {
            image.highlighted = YES;
        }
        else
        {
            image.highlighted = NO;
        }
    }
}
@end
