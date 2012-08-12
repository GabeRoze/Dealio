//
//  DealViewFavoritesCell.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-21.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.

//

#import <UIKit/UIKit.h>

@class XMLParser;

@interface DealViewFavoritesCell : UITableViewCell
{
//    BOOL favorited;
    UIActivityIndicatorView* spinner;
    
}

@property (assign, nonatomic) NSString* uid;
@property (assign, nonatomic) BOOL favorited;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;
@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UIImageView *spinnerView;
- (IBAction)favoritesButtonPressed:(id)sender;

-(void) connectToServer:(NSString*)data;

-(void)setFavoritedNo;
-(void)setFavoritedYes;
-(void) stopSpinner;
-(void) createAndDisplaySpinner;
//-(BOOL)getLiked;

@end
