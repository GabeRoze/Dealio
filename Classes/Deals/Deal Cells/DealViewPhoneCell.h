//
//  DealViewPhoneCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewPhoneCell : UITableViewCell

@property (copy, nonatomic) NSString* phone;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
