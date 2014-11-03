//
//  SPCLayer.h
//  Project Blink
//
//  Created by Peter Glanville on 5/21/14.
//  Copyright (c) 2014 SparkCompiler. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SPCLayer : CALayer{
   
    int indexInView;
   // CATextLayer *text;
    
}
@property (readwrite)int indexInView;
//@property (readwrite, copy)CATextLayer *text;

-(id)initWithIndex:(int)indexOfLayer;

@end


