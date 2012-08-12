//
//  DealViewResizableCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-20.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewResizableCell : UITableViewCell
{
    float cellHeight;
}

@property (copy, nonatomic) NSString* descriptonString;
@property (strong, nonatomic) IBOutlet UILabel *descriptionText;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


-(void)setCellHeight:(NSString*)str;
-(void)setCellHeightWithComment:(NSString*)str;
+(float) getCellHeight:(NSString*)str;
+(float) getCellHeightWithComment:(NSString*)str;
@end
