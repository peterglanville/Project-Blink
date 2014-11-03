//
//  SPCView.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 3/16/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCView.h"

@implementation SPCView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        /*
        first.x = 180;
        first.y = 400;
        
        path = [[NSBezierPath alloc]init];
        [path moveToPoint:first];
        first.x = first.x + 100;
        first.y = first.y + 200;
        [path lineToPoint:first];
        first.x = first.x + 100;
        first.y = first.y - 300;
        [path lineToPoint:first];
         
        */
        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    NSBezierPath *tempPath;
    
    [[NSColor colorWithCalibratedWhite:1.0 alpha:0.0]set];
    NSRectFill(dirtyRect);
    
    
    
	if (path != nil) {
        
        //NSLog(@"I am here");
        /*
        first.x = first.x + 15;
        first.y = first.y -20;
        [path lineToPoint:first];
         */
        [[NSColor greenColor] set];
        [path stroke];
    }
    
    /*
    if (tracingPaths != nil) {
        for (tempPath in d
    }
    */
}

- (void)updatePath:(NSBezierPath *)newPath
{
    path = newPath;
}

- (void)updateTracingPaths:(NSMutableArray *)paths
{
    tracingPaths = paths;
}


@end
