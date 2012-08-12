//
//  CINSegmentedControl.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 1/2/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CINSegmentedControl.h"

@implementation CINSegmentedControl


- (void) setSelectedSegmentIndex:(NSInteger)toValue {
    
    if (self.selectedSegmentIndex == toValue) {
        [super setSelectedSegmentIndex:UISegmentedControlNoSegment];
    } 
    else {
        [super setSelectedSegmentIndex:toValue];        
    }
}


@end
