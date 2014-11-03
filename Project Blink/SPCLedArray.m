//
//  SPCLedArray.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/29/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCLedArray.h"

#define LED_DIST    10
#define degToRad(x) (M_PI * x / 180.0)
#define ROTATION_FACTOR 0.004

@implementation SPCLedArray
@synthesize ledArrayNode;
@synthesize ledArray;

-(id)init {
    
    self = [super init];
    if (self) {
        
        ledArrayNode = [[SCNNode alloc]init];
        ledArray = [[NSMutableArray alloc]init];
        [self generateLedArray];
        
        
    }
    
    return self;
}

-(void)generateLedArray {
    
    int x;
    int y;
    SPCLedGeom *LED;
    
    
    
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.0",(LED_DIST * x),(LED_DIST * y)];
            
            LED = [[SPCLedGeom alloc]initWithOffsetX:(LED_DIST * x) with_Y:(LED_DIST * y) with_Z:0 and_Name:tempString];
            
            [LED addLedToRootNode:ledArrayNode];
            [ledArray addObject:LED];
        }
    }
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.%d",(LED_DIST * x),(LED_DIST * y), LED_DIST];
            
            LED = [[SPCLedGeom alloc]initWithOffsetX:(LED_DIST * x) with_Y:(LED_DIST * y) with_Z:LED_DIST and_Name:tempString];
            
            [LED addLedToRootNode:ledArrayNode];
            [ledArray addObject:LED];
        }
    }
    
    
    for (x = -1; x < 2; x++)
    {
        for (y = -1; y < 2; y++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d.%d.%d",(LED_DIST * x),(LED_DIST * y), ( -1 *LED_DIST)];
            
            LED = [[SPCLedGeom alloc]initWithOffsetX:(LED_DIST * x) with_Y:(LED_DIST * y) with_Z:(-1 *LED_DIST) and_Name:tempString];
            
            [LED addLedToRootNode:ledArrayNode];
            [ledArray addObject:LED];
        }
    }

}

@end
