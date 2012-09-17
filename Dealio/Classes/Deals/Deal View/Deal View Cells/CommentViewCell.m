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
    frame.origin.x = 5;
    frame.origin.y = 10;
    nameLabel.frame = frame;

    frame = CGRectMake(nameLabel.frame.size.width + 10, nameLabel.frame.origin.y, 30, nameLabel.frame.size.height);
    saysLabel.frame = frame;

    commentTextView.text = text;
    CGFloat height = [CalculationHelper calculateCellHeightWithString:text forWidth:320];
    frame = CGRectMake(5, 25, 320, height);
    commentTextView.frame = frame;

    ageLabel.text = [NSString stringWithFormat:@"%@ days ago", age];
    frame = CGRectMake(200, height, 75, 50);
    ageLabel.frame = frame;
}

@end
