//
//  DealViewDetailCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealViewDetailCell.h"

@implementation DealViewDetailCell
@synthesize dealNameLabel;
@synthesize numberLikesLabel;
@synthesize addToFavoritesLabel;


-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealViewDetailCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeAreaTapped:)];
    [likeSelectionArea addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoriteAreaTapped:)];
    [favoriteSelectionArea addGestureRecognizer:tapGestureRecognizer];

    return self;
}

-(IBAction)likeAreaTapped:(id)sender
{
    NSLog(@"LIKED");

    //todo connect to web
    //in success block
    [self setLiked:!liked];
    //fail block - present warning
}

-(IBAction)favoriteAreaTapped:(id)sender
{
    NSLog(@"FAVORITED");

    //todo connect to web
    //in success block
    [self setFavorited:!favorited];
    //fail block - present warning
}

-(void)setLiked:(BOOL)isLiked
{
    liked = isLiked;

    if (liked)
    {
        //todo - enable like image
        likedLabel.text = @"You did too!";
    }
    else
    {
        //todo -disable like image
        likedLabel.text = @"Did you love it?";
    }
}

-(void)setFavorited:(BOOL)isFavorited
{
    favorited = isFavorited;

    if (favorited)
    {
        //todo - enable favorite image
    }
    else
    {
        //todo -disable favorite image
    }
}

@end
