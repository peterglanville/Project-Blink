//
//  SPCledColor.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/30/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCledColor : NSObject {
    NSColor *ledColor;
    NSString *ledName;
}

@property (readwrite, copy) NSColor *ledColor;
@property (readwrite, copy) NSString *ledName;




- (id)initWithColor:(NSColor *)color AndName:(NSString *)name;
@end
