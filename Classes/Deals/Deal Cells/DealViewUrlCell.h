//
//  DealViewUrlCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewUrlCell : UITableViewCell

@property (copy, nonatomic) NSString* url;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
