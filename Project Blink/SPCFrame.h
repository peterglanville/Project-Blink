//
//  SPCFrame.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/30/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPCledColor.h"

@interface SPCFrame : NSObject {
    int second; // 0 - X
    int frameNumber; // 0 - 59
    NSMutableArray *ledArrayColors;
}

@property (readwrite) int second;
@property (readwrite) int frameNumber;
@property (readwrite, copy) NSMutableArray *ledArrayColors;

@end
