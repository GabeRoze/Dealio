//
//  CommentHeaderViewCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-17.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CommentHeaderViewCell.h"

@implementation CommentHeaderViewCell

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentHeaderViewCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}

@end
