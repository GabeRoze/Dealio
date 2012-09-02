//
//  MaleFemaleSelectionCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "MaleFemaleSelectionCell.h"

@implementation MaleFemaleSelectionCell


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MaleFemaleSelectionCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];


    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexSelected:)];
    [maleImage addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexSelected:)];
    [femaleImage addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(void)sexSelected:(UITapGestureRecognizer *)sender
{
    UIImageView *selectedImage = (UIImageView *)sender.view;

    if (selectedImage.tag == 0)
    {
        sex = @"male";
        maleImage.highlighted = YES;
        femaleImage.highlighted = NO;
    }
    else if (selectedImage.tag == 1)
    {
        sex = @"female";
        maleImage.highlighted = NO;
        femaleImage.highlighted = YES;
    }
}

@end
