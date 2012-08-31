//
//  TableHeaderCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UILabel *headerLabel;
}
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerLeftImage;
@property (strong, nonatomic) IBOutlet UIImageView *headerBackgroundImage;

@end
