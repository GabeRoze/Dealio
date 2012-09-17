//
//  CommentHeaderViewCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-17.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CommentHeaderViewCell.h"

@implementation CommentHeaderViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
