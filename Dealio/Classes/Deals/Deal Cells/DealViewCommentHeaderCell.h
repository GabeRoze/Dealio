//
//  DealViewCommentHeaderCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewCommentHeaderCell : UITableViewCell

@property (copy, nonatomic) NSString* numberComments;

@property (weak, nonatomic) IBOutlet UILabel *numberCommentsLabel;

@end
