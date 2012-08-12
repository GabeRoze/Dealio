//
//  DealViewMapInfoCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/19/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewMapInfoCell : UITableViewCell

@property (copy, nonatomic) NSString* streetAddress;
@property (copy, nonatomic) NSString* cityAddress;

@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityAddressLabel;

@end
