//
//  SPCTransparentWindowView.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 3/16/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCTransparentWindowView.h"

@implementation SPCTransparentWindowView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
   [[NSColor windowBackgroundColor]set];
   // [[NSColor greenColor]set];
   NSRectFill(dirtyRect);
    
    
    
}

@end
