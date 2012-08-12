//
//  DealViewLikeCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-20.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewLikeCell : UITableViewCell
{
    BOOL liked;
    
}


//@property (copy, nonatomic) NSString* text;
//@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;


//@property (assign, nonatomic) BOOL liked;


@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (IBAction)likeButtonPressed:(id)sender;

-(void) setLiked:(BOOL)status;

-(void)setLikedNo;
-(void)setLikedYes;
-(BOOL)getLiked;

@end
