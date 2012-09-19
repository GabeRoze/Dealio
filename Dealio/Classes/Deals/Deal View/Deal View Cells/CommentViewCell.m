//
//  CommentViewCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-17.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//



#import "CommentViewCell.h"
#import "CalculationHelper.h"

@implementation CommentViewCell

@synthesize commentTextView;
@synthesize nameLabel;
@synthesize saysLabel;
@synthesize ageLabel;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentViewCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}

-(void)setCommentTextViewWithString:(NSString *)text user:(NSString *)user age:(NSString *)age
{
    nameLabel.text = user;
    [nameLabel sizeToFit];

    CGRect frame = nameLabel.frame;
    frame.origin.x = 20;
    frame.origin.y = 10;
    nameLabel.frame = frame;

    frame = CGRectMake(nameLabel.frame.size.width + 25, nameLabel.frame.origin.y, 30, nameLabel.frame.size.height);
    saysLabel.frame = frame;


    commentTextView.text = [NSString stringWithFormat:@"\"%@\"", text];
    CGFloat height = [CalculationHelper calculateCellHeightWithString:text forWidth:280];
    frame = CGRectMake(20, 30, 280, height);
    commentTextView.frame = frame;

    frame = middleBackground.frame;
    frame.size.height = height + COMMENT_HEIGHT_MODIFIER;
    middleBackground.frame = frame;
    middleBackground.image = [UIImage imageNamed:@"commentboxmiddle.png"];

    frame = botomBackground.frame;
    frame.origin.y = height + COMMENT_HEIGHT_MODIFIER;
    botomBackground.frame = frame;

    if ([age isEqualToString:@"0"])
    {
        ageLabel.text = @"Today";
    }
    else if ([age isEqualToString:@"1"])
    {
        ageLabel.text = [NSString stringWithFormat:@"%@ day ago", age];
    }
    else
    {
        ageLabel.text = [NSString stringWithFormat:@"%@ days ago", age];
    }
    frame = CGRectMake(ageLabel.frame.origin.x, height+8, ageLabel.frame.size.width, ageLabel.frame.size.height);
    ageLabel.frame = frame;
}

@end
