//
//  DealViewDetailCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealViewDetailCell : UITableViewCell
{
    IBOutlet UIImageView *likeButton;
    IBOutlet UIImageView *favoriteButton;
    IBOutlet UILabel *likedLabel;
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *favoriteSelectionArea;
    IBOutlet UIImageView *likeSelectionArea;

    BOOL liked;
    BOOL favorited;

}
@property (strong, nonatomic) IBOutlet UILabel *dealNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLikesLabel;
@property (strong, nonatomic) IBOutlet UILabel *addToFavoritesLabel;


-(void)setLiked:(BOOL)isLiked;
-(void)setFavorited:(BOOL)isFavorited;

@end
