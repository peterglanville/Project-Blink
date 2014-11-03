//
//  SPCLayer.m
//  Project Blink
//
//  Created by Peter Glanville on 5/21/14.
//  Copyright (c) 2014 SparkCompiler. All rights reserved.
//

#import "SPCLayer.h"

@implementation SPCLayer

-(id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    
    return self;
}

-(id)initWithIndex:(int)indexOfLayer{
    
    self = [self init];
    
    if (self) {
        _indexInView = indexOfLayer;
        /*
        _text = [CATextLayer layer];
        NSString *textString = [NSString stringWithFormat:@"%d",_indexInView];
        //[text setString:textString];
        //[self addSublayer:text];
        
      //  textString = text.string;
        
        [_text setFont:@"Helvetica-Bold"];
        [_text setFontSize:20];
        //[_text setFrame:self.frame];
        [_text setString:textString];
        [_text setAlignmentMode:kCAAlignmentCenter];
        [_text setForegroundColor:[[NSColor whiteColor] CGColor]];
        [self addSublayer:_text];
        
         */
    }
    
    
    return self;
}

@end