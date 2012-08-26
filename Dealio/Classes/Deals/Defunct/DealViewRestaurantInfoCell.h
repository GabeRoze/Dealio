//
//  DealViewRestaurantInfoCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 2/29/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewRestaurantInfoCell : UITableViewCell

@property (copy, nonatomic) NSString* streetAddress;
@property (copy, nonatomic) NSString* cityAddress;
@property (copy, nonatomic) NSString* phone;
@property (copy, nonatomic) NSString* url;

//@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;


@property (strong, nonatomic) UILabel* streetAddressLabel;
@property (strong, nonatomic) UILabel* cityAddressLabel;
@property (strong, nonatomic) UILabel* phoneLabel;
@property (strong, nonatomic) UILabel* urlLabel;


-(void)setStreetAddress:(NSString*)n;
-(void)setCityAddress:(NSString*)n withState:(NSString*)state;
-(void)setPhone:(NSString*)n;
-(void)setUrl:(NSString*)n;

@end
