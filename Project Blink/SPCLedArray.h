//
//  SPCLedArray.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 4/29/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
#import "SPCLedGeom.h"

@interface SPCLedArray : NSObject {
    SCNNode *ledArrayNode;
    NSMutableArray *ledArray;
}

@property (readwrite, copy)SCNNode *ledArrayNode;
@property (readwrite, copy)NSMutableArray *ledArray;


-(void)generateLedArray;
@end
