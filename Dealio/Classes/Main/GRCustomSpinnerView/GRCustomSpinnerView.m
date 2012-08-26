//
//  BorderedSpinnerView.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 2/15/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "GRCustomSpinnerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GRCustomSpinnerView

+(GRCustomSpinnerView*)instance
{
    static GRCustomSpinnerView* instance = nil;

    if (!instance)
    {
        instance = [[GRCustomSpinnerView alloc] initWithNibName:@"GRCustomSpinnerView" bundle:nil];
    }
    return instance;
}

#pragma mark - View lifecycle
-(void)displaySpinner
{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner setCenter:CGPointMake(spinnerImageView.bounds.size.width/2.0,spinnerImageView.bounds.size.height/2.0)];
    [spinnerImageView addSubview:spinner];
    [spinner startAnimating];
}

-(void)addSpinnerToView:(UIView *)view
{
    [view addSubview:self.view];
    [self displaySpinner];
}

-(void)stopSpinner
{
    [spinner stopAnimating];
    [self.view removeFromSuperview];
}

@end
