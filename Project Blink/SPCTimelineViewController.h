//
//  SPCTimelineViewController.h
//  Project Blink
//
//  Created by Peter Glanville on 5/10/14.
//  Copyright (c) 2014 SparkCompiler. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SPCTimelineView.h"
#import "SPCLayer.h"
#import "SPCTransparentWindowView.h"
//@class SPCTimelineView;

@interface SPCTimelineViewController : NSViewController
{
    IBOutlet SPCTimelineView *timelineView;
    IBOutlet SPCTransparentWindowView *transparentWindowView;
    
    NSPoint mouseOriginalLocation;
    NSPoint mouseDraggedLocation;
    NSPoint mouseOldLocation;
    
    SPCLayer *tiledScrollingLayer;
    SPCLayer *selectedLayer;
    SPCLayer *head;
    SPCLayer *tail;
}

@property (readwrite)NSPoint mouseOriginalLocation;
@property (readwrite)NSPoint mouseDraggedLocation;
@property (readwrite)NSPoint mouseOldLocation;
@property (readwrite, copy) SPCLayer *tiledScrollingLayer;
@property (readwrite, copy) SPCLayer *selectedLayer;
@property (readwrite, copy) SPCLayer *head;
@property (readwrite, copy) SPCLayer *tail;


-(float)selectedLayerPosition:(CGPoint) mousePreDragLocation With: (CGPoint) mouseClickLocation And:(CGPoint) layerPosition;

-(float)newPositionForAdjacentLayer:(CGPoint) selectedLayerOriginalPosition With: (CGPoint) selectedLayerNewPosition And: (CGPoint) adjacentLayerPosition;

-(void)generateTimelineViewLayers;
-(BOOL)testRectInView:(NSRect)testRect;
-(BOOL)rectIsNearWidthOfViewLayerFrame:(NSRect)testRect;
-(BOOL)rectIsNearOriginOfViewLayerFrame:(NSRect)testRect;
-(NSUInteger )layerIndexNearestViewLayerFrameWidthBoundry;
-(NSUInteger)layerIndexNearestViewLayerFrameOriginBoundry;
@end
