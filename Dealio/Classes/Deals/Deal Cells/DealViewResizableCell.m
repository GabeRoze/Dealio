//
//  DealViewResizableCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-20.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewResizableCell.h"

@implementation DealViewResizableCell
@synthesize descriptionText;
@synthesize descriptionLabel;
@synthesize descriptonString;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)viewDidUnload
{
    [self viewDidUnload];
    self.descriptionLabel = nil;
    self.descriptonString = nil;
}

-(void) layoutSubviews {
    [super layoutSubviews];
}


-(void)setCellHeight:(NSString*)str{
    
    self.descriptionText.text = @"";
    
    
    UIFont* font = [UIFont systemFontOfSize:14];
    
    if (![str isEqualToString:descriptonString])
    {
    self.descriptonString = [str copy];   
    }
    self.descriptionText = [[UILabel alloc] initWithFrame:CGRectZero];
    self.descriptionText.backgroundColor = [UIColor clearColor];
    self.descriptionText.font = font;
    self.descriptionText.numberOfLines = 0;
   // [self.contentView addSubview:self.descriptionText];

    
 //  self.descriptionText.text = descriptonString;

    // Fontsize;
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [descriptonString sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    
    //previously 280 was 260
    CGRect frame = CGRectMake(20, 40, 280, expectedLabelSize.height+10);
    //self.descriptionText.frame = CGRectMake(0.0f, 0.0f, 100.0f, 50.0f);
    self.descriptionText.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.descriptionText.frame = frame;
    
    
    [self.contentView addSubview:self.descriptionText];
    self.descriptionText.text = descriptonString;
    
    
    cellHeight = expectedLabelSize.height;

}

-(void)setCellHeightWithComment:(NSString*)str{
    
    descriptionLabel.hidden = YES;
    
    UIFont* font = [UIFont systemFontOfSize:14];
    
    
    if (![str isEqualToString:descriptonString])
    {
    self.descriptonString = [str copy];
    }
    self.descriptionText = [[UILabel alloc] initWithFrame:CGRectZero];
    self.descriptionText.backgroundColor = [UIColor clearColor];
    self.descriptionText.font = font;
    self.descriptionText.numberOfLines = 0;
  //  [self.contentView addSubview:self.descriptionText];
    
    
   // self.descriptionText.text = descriptonString;
    
    // Fontsize;
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [descriptonString sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = CGRectMake(20, 10, 260, expectedLabelSize.height+10);

    self.descriptionText.frame = CGRectMake(0.0f, 0.0f, 100.0f, 50.0f);
    self.descriptionText.frame = frame;
    
    [self.contentView addSubview:self.descriptionText];
    self.descriptionText.text = descriptonString;
    
    cellHeight = expectedLabelSize.height;
    
}


+(float) getCellHeight:(NSString*)str {
    
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    return expectedLabelSize.height+65;
}


+(float) getCellHeightWithComment:(NSString*)str {
    
    CGFloat size = 14;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat maxHeight = 9999;
    CGSize maxLabelSize = CGSizeMake(maxWidth, maxHeight);
    CGSize expectedLabelSize = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maxLabelSize lineBreakMode:UILineBreakModeWordWrap];
    
    
    return expectedLabelSize.height+30;
}

@end
