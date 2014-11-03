//
//  SPCledColor.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/30/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCledColor.h"

@implementation SPCledColor


- (id)initWithColor:(NSColor *)color AndName:(NSString *)name
{
    
    self = [super init];
    if (self) {
        
        _ledColor = color;
        _ledName = name;
        
    }
    
    return self;
    
}


@end
