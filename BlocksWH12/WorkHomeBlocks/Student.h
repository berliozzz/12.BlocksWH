//
//  Student.h
//  WorkHomeBlocks
//
//  Created by Nikolay Berlioz on 19.09.15.
//  Copyright (c) 2015 Nikolay Berlioz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *laststName;
@property (assign, nonatomic) CGFloat temperature;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;


@end
