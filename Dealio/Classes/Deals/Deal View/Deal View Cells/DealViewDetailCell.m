//
//  DealViewDetailCell.m
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "DealViewDetailCell.h"
#import "DealioService.h"
#import "XMLParser.h"
#import "GRCustomSpinnerView.h"

@implementation DealViewDetailCell

@synthesize dealNameLabel;
@synthesize numberLikesLabel;
@synthesize addToFavoritesLabel;
@synthesize uid;


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
    [dealNameLabel setFont:[UIFont fontWithName:@"Rokkitt-Bold" size:dealNameLabel.font.pointSize]];

    return self;
}

-(IBAction)likeAreaTapped:(id)sender
{
    //todo find out initial like number

    [DealioService updateLikedForUID:uid onSuccess:^(NSData *data) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            XMLParser *parser = [[XMLParser alloc] initXMLParser:data];

            dispatch_async(dispatch_get_main_queue(), ^{
                [GRCustomSpinnerView.instance stopSpinner];
                NSMutableDictionary *parserData = [NSMutableDictionary dictionaryWithDictionary:parser.userFunction];

                if ([[parserData objectForKey:@"message"] isEqualToString:@"fail"])
                {
                    NSLog(@"failed to like");
                    [DealioService webConnectionFailed];
                }
                else
                {
                    [self setLiked:!liked numLikes:[[parserData objectForKey:@"message"] intValue]];
                }
            });
        });
    }
                           onFailure:nil];
}

-(IBAction)favoriteAreaTapped:(id)sender
{
    //todo - fix for add/remove likes

    NSString *command = nil;

    if (favorited)
    {
        command = @"remove";
    }
    else
    {
        command = @"add";
    }

    [DealioService updateFavoritedForUID:uid command:command onSuccess:^(NSData *data){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            XMLParser *parser = [[XMLParser alloc] initXMLParser:data];

            dispatch_async(dispatch_get_main_queue(), ^{
                [GRCustomSpinnerView.instance stopSpinner];
                NSMutableDictionary *parserData = [NSMutableDictionary dictionaryWithDictionary:parser.userFunction];

                if ([[parserData objectForKey:@"message"] isEqualToString:@"success"])
                {
                    [self setFavorited:!favorited];

                }
                else
                {
                    NSLog(@"failed to favorite");
                    [DealioService webConnectionFailed];
                }
            });
        });
    }
                               onFailure:nil];
}

-(void)setLiked:(BOOL)isLiked numLikes:(int)numLikes;
{
    liked = isLiked;

    if (liked)
    {
        numberLikesLabel.text = [NSString stringWithFormat:@"%i Loved it!", numLikes];
        likedLabel.text = @"You did too!";
        likeButton.image = [UIImage imageNamed:@"button_love_s.png"];
    }
    else
    {
        numberLikesLabel.text = [NSString stringWithFormat:@"%i Loved it!", numLikes];
        likedLabel.text = @"Did you love it?";
        likeButton.image = [UIImage imageNamed:@"button_love.png"];
    }
}

-(void)setFavorited:(BOOL)isFavorited
{
    favorited = isFavorited;

    if (favorited)
    {
        favoriteButton.image = [UIImage imageNamed:@"button_favorite_s.png"];
    }
    else
    {
        favoriteButton.image = [UIImage imageNamed:@"button_favorite.png"];
    }
}

-(void)loadInitialValuesWithFavorited:(NSString *)isFavorited liked:(NSString *)isLiked numLikes:(NSString *)numLikes
{
    if ([isFavorited isEqualToString:@"0"])
    {
        [self setFavorited:NO];
    }
    else
    {
        [self setFavorited:YES];
    }

    if ([isLiked isEqualToString:@"0"])
    {
        [self setLiked:NO numLikes:[numLikes intValue]];
    }
    else
    {
        [self setLiked:YES numLikes:[numLikes intValue]];
    }
}


@end
