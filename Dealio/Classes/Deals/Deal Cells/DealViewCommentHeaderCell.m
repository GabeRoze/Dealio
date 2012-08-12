//
//  DealViewCommentHeaderCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewCommentHeaderCell.h"

@implementation DealViewCommentHeaderCell


@synthesize numberComments;
@synthesize numberCommentsLabel;

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



-(void)setNumberComments:(NSString*)n{
    if (![n isEqualToString:numberComments]){
        numberComments = [n copy];
        
        int numComments;
        numComments = [numberComments intValue];
        
        if (numComments > 0) {
            numberCommentsLabel.text = [numberComments stringByAppendingString:@" Comments"];
        }
        else {
            numberCommentsLabel.text = @"No Comments";
        }
        
    }
}

@end
