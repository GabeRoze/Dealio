//
//  DealViewCell.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-15.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "DealViewCell.h"

//#define kNameValueTag 1
//#define kColorValueTag 2



@implementation DealViewCell

@synthesize name;
@synthesize color;
@synthesize nameLabel;
@synthesize colorLabel;


/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = UITextAlignmentRight;
        nameLabel.text = @"Name:";
        nameLabel.font = [UIFont boldSystemFontOfSize:12];
        //add label to the cell
        [self.contentView addSubview:nameLabel];
        
        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
        UILabel* colorLabel = [[UILabel alloc] initWithFrame:colorLabelRect];
        colorLabel.textAlignment = UITextAlignmentRight;
        colorLabel.text = @"Color:";
        colorLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorLabel];
        
        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
        UILabel* nameValue = [[UILabel alloc] initWithFrame:nameValueRect];
        nameValue.tag = kNameValueTag;
        [self.contentView addSubview:nameValue];
        
        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
        UILabel* colorValue = [[UILabel alloc] initWithFrame:colorValueRect];
        colorValue.tag = kColorValueTag;
        [self.contentView addSubview:colorValue];
        
    }
    return self;
}
*/


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString*)n{
    
    
    if (![n isEqualToString:name]){
        name = [n copy];
      //  UILabel* nameLabel = (UILabel*)[self.contentView viewWithTag:kNameValueTag];
        nameLabel.text = name;
        NSLog(@"name copy is %@", n);
    }
   // name = [n copy];
    //nameLabel.text = n;
    
    
    
}

-(void)setColor:(NSString*)c{
    if (![c isEqualToString:color]){
        color = [c copy];
       // UILabel* colorLabel = (UILabel*)[self.contentView viewWithTag:kColorValueTag];
        colorLabel.text = color;
    }
}

@end
