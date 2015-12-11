//
//  Student.m
//  WorkHomeBlocks
//
//  Created by Nikolay Berlioz on 19.09.15.
//  Copyright (c) 2015 Nikolay Berlioz. All rights reserved.
//

#import "Student.h"

@implementation Student


- (BOOL) howAreYou
{
    BOOL iFeelGood = arc4random() % 2;
    
    return iFeelGood;
}

- (void) takePill
{
    NSLog(@"%@ takes a pill", self.firstName);
}

- (void) makeShot
{
    NSLog(@"%@ takes a shot", self.firstName);
    
}

@end
