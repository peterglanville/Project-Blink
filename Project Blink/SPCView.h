//
//  SPCView.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 3/16/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface SPCView : SCNView {
    NSBezierPath *path;
    NSMutableArray *tracingPaths;
    NSPoint first;
}

- (void)updatePath:(NSBezierPath *)newPath;
@end
