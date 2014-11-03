//
//  SPCFrame.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/30/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCFrame.h"

#define LED_DIST    10

@implementation SPCFrame

- (id)initWithBlankFrame
{
    self = [super init];
    if (self) {
        _second = 0;
        _frameNumber = 0;
        _ledArrayColors = [[NSMutableArray alloc]init];
        
        [self generateColorArray];
        
        
        
    }
    
    return self;
}


-(void)generateColorArray
{
    int x;
    int y;
    
    SPCledColor *ledColor;
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.0",(LED_DIST * x),(LED_DIST * y)];
            ledColor = [[SPCledColor alloc]initWithColor:[[NSColor alloc]init] AndName:tempString];
            [_ledArrayColors addObject:ledColor];
            
        }
    }
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.%d",(LED_DIST * x),(LED_DIST * y), LED_DIST];
            ledColor = [[SPCledColor alloc]initWithColor:[[NSColor alloc]init] AndName:tempString];
            [_ledArrayColors addObject:ledColor];
        }
    }
    
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.%d",(LED_DIST * x),(LED_DIST * y), ( -1 *LED_DIST)];
            
            ledColor = [[SPCledColor alloc]initWithColor:[[NSColor alloc]init] AndName:tempString];
            [_ledArrayColors addObject:ledColor];
        }
    }

}

@end
