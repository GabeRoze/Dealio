//
//  DealViewRestaurantInfoCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 2/29/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealViewRestaurantInfoCell.h"

@implementation DealViewRestaurantInfoCell

@synthesize streetAddress;
@synthesize cityAddress;
@synthesize streetAddressLabel;
@synthesize cityAddressLabel;
@synthesize phone;
@synthesize phoneLabel;
@synthesize url;
@synthesize urlLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //Remove the outline of the cell
        //self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)setStreetAddress:(NSString*)n{
    
    if (![n isEqualToString:streetAddress]){
        streetAddress = [n copy];
        //streetAddressLabel.text = streetAddress;
        
        streetAddressLabel.text = @"";        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 280, 25)];
        label.tag = 42;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:22];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;
        label.text= streetAddress;
        UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
        tapGesture.minimumPressDuration = 0.001;

        //UIGestureRecognizerStateEnded
        
        //        [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)]];
        [label addGestureRecognizer:tapGesture];
        streetAddressLabel = label;
        
        
        //[label addTarget:self action:@selector(addressPressed:) forControlEvents:UIControlEventTouchDown];
        
        [self.contentView addSubview:label];
                
    }
}



-(void)setCityAddress:(NSString*)n withState:(NSString*)state{
    if (![n isEqualToString:cityAddress]){

        cityAddress= [NSString stringWithFormat:@"%@, %@",n, state]; 
        cityAddressLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 280, 25)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:22];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;

        label.text= cityAddress;
        UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
        tapGesture.minimumPressDuration = 0.001;
        [label addGestureRecognizer:tapGesture];
        cityAddressLabel = label;
        [self.contentView addSubview:label];
    }
}


-(void)setPhone:(NSString*)n {
    
    if (![n isEqualToString:phone]){
        
        phone = [n copy];
        phoneLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 85, 280, 25)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:22];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;
        
        label.text= phone;
        UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(phoneTap:)];
        tapGesture.minimumPressDuration = 0.001;
        [label addGestureRecognizer:tapGesture];
        phoneLabel = label;
        [self.contentView addSubview:label];
    }
}

-(void)setUrl:(NSString*)n {
    
    if (![n isEqualToString:url]){
        
        url = [n copy];
        urlLabel.text = @"";
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 280, 25)];
        label.tag = 43;
        label.font = [UIFont fontWithName:@"Eurofurenceregular" size:22];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor brownColor];
        label.userInteractionEnabled = YES;
        
        label.text= url;
        UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(urlTap:)];
        tapGesture.minimumPressDuration = 0.001;
        [label addGestureRecognizer:tapGesture];
        urlLabel = label;
        [self.contentView addSubview:label];
    }
}




-(IBAction)labelTap:(UILongPressGestureRecognizer *)gesture  {
    
    streetAddressLabel.textColor = [UIColor blackColor];
    cityAddressLabel.textColor = [UIColor blackColor];
    
    //If the tap ended
    if (UIGestureRecognizerStateEnded == gesture.state){        
        streetAddressLabel.textColor = [UIColor whiteColor];
        cityAddressLabel.textColor = [UIColor whiteColor];
    }
    
}

-(IBAction)phoneTap:(UILongPressGestureRecognizer *)gesture  {
    
    phoneLabel.textColor = [UIColor blackColor];
    
    //If the tap ended
    if (UIGestureRecognizerStateEnded == gesture.state){        
        phoneLabel.textColor = [UIColor whiteColor];
    }
}

-(IBAction)urlTap:(UILongPressGestureRecognizer *)gesture  {
    
    urlLabel.textColor = [UIColor blackColor];
    
    //If the tap ended
    if (UIGestureRecognizerStateEnded == gesture.state){        
        urlLabel.textColor = [UIColor whiteColor];
    }
}
@end
