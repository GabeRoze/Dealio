//
//  DealViewCommentCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewCommentCell.h"

@implementation DealViewCommentCell

@synthesize commentLabel;
@synthesize commentText;

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


-(void)setCellHeight:(NSString *)str {
    

    
    //self.commentLabel.frame = CGRectMake(0.0f, 0.0f, 100.0f, 50.0f);
//    commentLabel = nil;
    
    [commentLabel removeFromSuperview];
    
    
    UIFont* font = [UIFont systemFontOfSize:14];
    
   // self.commentText = [str copy];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.commentLabel.backgroundColor = [UIColor clearColor];
    self.commentLabel.font = font;
    self.commentLabel.numberOfLines = 0;
    
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = CGRectMake(20, 10, 260, expectedLabelSize.height+10);

    self.commentLabel.frame = frame;
    
    /*
    if (commentText == nil){
        commentText = [str copy];
        commentLabel.text = commentText;
        [self.contentView addSubview:self.commentLabel];
    }
    NSLog(str);*/

}


+(float) getCellHeight:(NSString*) str {
    
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    return expectedLabelSize.height+30;
}


-(void)setCommentText:(NSString*)n{
        //commentText = nil;
        commentText = [n copy];
        commentLabel.text = commentText;
        [self.contentView addSubview:self.commentLabel];

    
}


@end
