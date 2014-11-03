//
//  SPCSceneViewController.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 1/12/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>
#import "SPCLedGeom.h"
#import "SPCView.h"
#import "SPCTransparentWindowView.h"
#import "SPCLedArray.h"
#import "SPCTimelineView.h"


@interface SPCSceneViewController : NSViewController {
    IBOutlet SPCView *sceneView;
    
    
    SPCTransparentWindowView *originalView;
    SCNNode *cameraNode;
    SCNNode *cameraRotationNode;
    SCNNode *root;
    SCNCamera *camera;
    
    SPCLedGeom *clickedLED;
    NSString *clickedLEDName;
    
    NSPoint mouseOriginalLocation;
    NSPoint mouseDraggedLocation;
    NSPoint mouseOldLocation;

    
    float angleX;
    float angleY;
    CATransform3D initalLEDTransform;
    
    IBOutlet NSColorWell *ledColorWell;
    
    CAShapeLayer *lineLayer;
    
    NSBezierPath *pathForOutline;
    
    NSMutableArray *tracingLines;
    
    SPCLedArray *ledArray;
    
    BOOL sceneViewLock;
    BOOL timelineViewLock;

}

@property (readwrite, copy)SPCTransparentWindowView* originalView;
@property (readwrite, retain)SPCLedArray *ledArray;
@property (readwrite, copy)SPCLedGeom *clickedLED;
@property (readwrite, copy)NSString *clickedLEDName;
@property (readwrite)NSPoint mouseOriginalLocation;
@property (readwrite)NSPoint mouseDraggedLocation;
@property (readwrite)NSPoint mouseDraggedOffset;
@property (readwrite, copy)SCNNode *cameraNode;
@property (readwrite, copy)SCNNode *cameraRotationNode;
@property (readwrite, copy)SCNCamera *camera;
@property (readwrite, copy)SCNNode *ledArrayNode;
@property (readwrite, copy)SCNNode *root;
@property (readwrite)BOOL isMouseDraggedStateBegin;
@property (readwrite)float angleX;
@property (readwrite)float angleY;
@property (readwrite)CATransform3D initalLEDTransform;
@property (readwrite)NSPoint mouseOldLocation;
@property (readwrite, copy)CAShapeLayer *lineLayer;
@property (readwrite, copy)NSBezierPath *pathForOutline;
@property (readwrite, copy)NSMutableArray *tracingLines;

@property (readwrite) BOOL scenViewLock;
@property (readwrite) BOOL timelineViewLock;


- (IBAction)changeLEDColor:(id)sender;
- (void)printCATransform:(CATransform3D)transform;
- (void)initializeVariablesAndWindow_ViewEnvironment;
- (void)buildSceneAndImportLedArray;
- (void)lockTimelineView;
- (void)lockSceneView;

@end
