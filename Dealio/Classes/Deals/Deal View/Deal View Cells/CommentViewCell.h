//
//  CommentViewCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-09-17.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *saysLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

-(void)setCommentTextViewWithString:(NSString *)text user:(NSString *)user age:(NSString *)age;

@end
