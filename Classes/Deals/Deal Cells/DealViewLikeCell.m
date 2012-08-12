//
//  DealViewLikeCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-20.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewLikeCell.h"

@implementation DealViewLikeCell

//@synthesize text;
//@synthesize descriptionLabel;
//@synthesize accessoryImageView;
@synthesize likeButton;
//@synthesize liked;

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

/*
 -(void)setText:(NSString*)n{
 if (![n isEqualToString:text]){
 text = [n copy];
 descriptionLabel.text = text;
 }
 }
 */

/*
 -(void)setLiked:(BOOL)status {
 
 
 if (status == YES) {
 self.likeButton.imageView.image = [UIImage imageNamed:@"34-circle-minus.png"];
 liked = YES;
 
 }
 else  {
 NSLog(@"d");
 self.likeButton.imageView.image = [UIImage imageNamed:@"33-circle-plus.png"]; 
 liked = NO;
 //
 
 
 }
 }
 */

-(BOOL)getLiked {
    return liked;
}

-(void)setLikedNo {
    liked = NO;
    [likeButton setImage:[UIImage imageNamed:@"33-circle-plus.png"] forState:UIControlStateNormal];
}

-(void)setLikedYes {
    liked = YES;
      [likeButton setImage:[UIImage imageNamed:@"34-circle-minus.png"] forState:UIControlStateNormal];
}

- (IBAction)likeButtonPressed:(id)sender {
    
    if (liked == YES) {
        [likeButton setImage:[UIImage imageNamed:@"33-circle-plus.png"] forState:UIControlStateNormal];
        liked = NO;
    
        //send notification to dealview that like has been removed
        
    }
    else {
        [likeButton setImage:[UIImage imageNamed:@"34-circle-minus.png"] forState:UIControlStateNormal];
        liked = YES;
        
        //send notification to dealview that like has been added
    }
    
}
@end
