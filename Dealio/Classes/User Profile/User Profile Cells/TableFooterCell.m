//
//  TableFooterCell.m
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableFooterCell.h"

@implementation TableFooterCell

@synthesize backgroundImageView;

-(id)init
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableFooterCell"
                                                 owner:self
                                               options:nil];
    self = [nib objectAtIndex:0];

    return self;
}



@end
