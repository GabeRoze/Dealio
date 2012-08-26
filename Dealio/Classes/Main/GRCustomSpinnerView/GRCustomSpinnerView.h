//
//  BorderedSpinnerView.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 2/15/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRCustomSpinnerView : UIViewController
{
    UIActivityIndicatorView* spinner;
    IBOutlet UIImageView *spinnerImageView;
}

+(GRCustomSpinnerView*)instance;
-(void) addSpinnerToView:(UIView *)view;
-(void) stopSpinner;

@end
