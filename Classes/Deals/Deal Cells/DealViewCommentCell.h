//
//  DealViewCommentCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewCommentCell : UITableViewCell

@property (copy, nonatomic) NSString* commentText;

@property (strong, nonatomic) UILabel* commentLabel;


-(void)setCellHeight:(NSString*)str;
+(float) getCellHeight:(NSString*) str;

@end
