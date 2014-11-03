//
//  SPCTimelineViewController.m
//  Project Blink
//
//  Created by Peter Glanville on 5/10/14.
//  Copyright (c) 2014 SparkCompiler. All rights reserved.
//

#import "SPCTimelineViewController.h"

@interface SPCTimelineViewController ()

@end

@implementation SPCTimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
      
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    
    // Init stuff:
    
    mouseOriginalLocation.x = 0;
    mouseOriginalLocation.y = 0;
    mouseDraggedLocation.x = 0;
    mouseDraggedLocation.y = 0;
    
    
    
    self.view.nextResponder = self;
    
    [self generateTimelineViewLayers];
    
    
   
}

- (void)mouseDown:(NSEvent *)theEvent
{
    
    NSPoint winp    = [theEvent locationInWindow];
    NSPoint p       = [timelineView convertPoint:winp fromView:transparentWindowView];
    
    if (NSPointInRect(p, timelineView.bounds)) {
        
        mouseOriginalLocation = p;
        mouseOldLocation = p;
     
     // Get the CALayer that I clicked on (need to make my own later once they
     // become more complex.)
     // "select" it and save all the location info.
     // Then see if we move in MouseDragged.
        

        _selectedLayer = [self.view.layer hitTest:winp]; // getting a hittest from the frame of the layer, wrt to windowLocation
        
        if (_selectedLayer != NULL) {
            //_selectedLayer.borderColor = [NSColor redColor].CGColor;
            //_selectedLayer.borderWidth = (CGFloat) 1.0;
            
            }
        

    }
}


- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint winp    = [theEvent locationInWindow];
    NSPoint p      = [timelineView convertPoint:winp fromView:transparentWindowView];
    
    if (NSPointInRect(p, timelineView.bounds)) {
        
        mouseDraggedLocation = p;
        

       
        CGPoint point;
        point.x = p.x;
        point.y = _selectedLayer.position.y;
       
        
        CGRect updatedRect;
        
        
        if (_selectedLayer != NULL) {
            if (_selectedLayer != self.view.layer) {
                
                CGPoint selectedLayerPreDragPosition = _selectedLayer.position;
                
                [CATransaction begin];
                [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
                _selectedLayer.position = CGPointMake([self selectedLayerPosition:mouseOldLocation With: point And: _selectedLayer.position], point.y);
                [CATransaction commit];
                
                for (CALayer *tempLayer in self.view.layer.sublayers){
                    
                    //NSLog(@"* 1st Position: x = %f, y = %f", tempLayer.position.x, tempLayer.position.y);
                    
                    if (tempLayer != _selectedLayer){
                        
                        [CATransaction begin];
                        [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

                        tempLayer.position = CGPointMake([self newPositionForAdjacentLayer:selectedLayerPreDragPosition With:_selectedLayer.position And:tempLayer.position], point.y);
                        [CATransaction commit];
                    }
                    
                    
                                       // find direction at beginning
                    // depending on direction, see if the tail or head is withing the rootLayer
                    // rect
                    // If not update it to the next one depending on direction
                    // Then update the buddy accordingly.
                    
                    
                }
                
                
                float movementSign = point.x - mouseOldLocation.x;
                
                CGRect testRect;
                SPCLayer *moveLayer;
                CGRect moveRect;
                
                
                // I think the way to make it so that I shift stuff to either side.
                // Lets do it the dumb way, if I move:
                //      To the left:
                //          If I pop the head, move the end of the array, to the beginning
                //          Then uddate its position by a "legnth"
                //
                /*
                 THis is a little too dumb. If the move distance is very large, and the width
                 of the cells is very small, we run into the issue where I will see the root layer. 
                 
                 What I need to do it test ahead / behind until I have the cell that is nearest
                 to the origin / frame width and then I can set the head / tail to that and then update the number of cells on the other end until we are past the visible spot and mark the tail / head in the same way, thereby getting past this bug.
                 
                 
                 
                 
                 
                 */
                
                [CATransaction begin];
                [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
                
                if (movementSign < 0) {
                    // moving to the left
                    // test the head
                    testRect = head.frame;
                    NSInteger indexValue;
                    NSUInteger numberOfLayersPastWidthBoundy;
                    
                    
                    if (![self testRectInView:testRect]) {
                            
                        head.borderWidth = 0;
                        head.borderColor = [NSColor clearColor].CGColor;
                        indexValue = [timelineView.layer.sublayers indexOfObject:head];
                            // head is not in view, update head to next in line.
                        for (indexValue = indexValue; ![self testRectInView:testRect]; ++indexValue) {
                            
                            head = [timelineView.layer.sublayers objectAtIndex:indexValue];
                            
                            testRect = head.frame;
                        }
                        
                        head.borderColor = [NSColor blueColor].CGColor;
                        head.borderWidth = 2.0;
                            //next in array;
                            
                            // deselect head;
                            // move tail but must do error checking? or not something like generate new for tail?
                        
                        
                        
                        
                        do {
                            moveLayer = [timelineView.layer.sublayers firstObject];
                            [moveLayer removeFromSuperlayer];
                            moveRect = [[timelineView.layer.sublayers lastObject] frame];
                            moveRect.origin.x = moveRect.origin.x + moveRect.size.width;
                            moveLayer.frame = moveRect;
                            
                            [timelineView.layer insertSublayer:moveLayer atIndex:(int)[timelineView.layer.sublayers count]];
                            
                        } while ([self testRectInView:moveRect]);
                        
                        
                        tail.borderWidth = 0;
                        tail.borderColor = [NSColor clearColor].CGColor;
                        
                        testRect = tail.frame;
                        
                        // head is not in view, update tail to next in line.
                        indexValue = [self layerIndexNearestViewLayerFrameWidthBoundry];
                        
                        //indexValue = [timelineView.layer.sublayers indexOfObject:tail];
                        
                       // indexValue++;
                        
                        
                                
                            tail = [timelineView.layer.sublayers objectAtIndex:indexValue];
                            tail.borderColor = [NSColor purpleColor].CGColor;
                            tail.borderWidth = 2.0;
                        
                        
                        
                        // we need to move the last item in the layer.sublayers from the end
                        // to the beginning. Then update its position.
                       
                        
                        
                        
                            
                    }
                } else if (movementSign > 0) {
                    // moving to the right
                    // test the tail
                    testRect = tail.frame;
                    NSInteger indexValue = [timelineView.layer.sublayers indexOfObject:tail];
                    
                    
                    if (![self testRectInView:testRect]) {
                        
                        tail.borderWidth = 0;
                        tail.borderColor = [NSColor clearColor].CGColor;
                        
                        // head is not in view, update head to next in line.
                        
                        
                        indexValue = [timelineView.layer.sublayers indexOfObject:tail];
                        
                       // indexValue--;
                        
                        for (indexValue = indexValue; ![self testRectInView:testRect]; indexValue--) {
                            
                            tail = [timelineView.layer.sublayers objectAtIndex:indexValue];
                            
                            testRect = tail.frame;
                        }

                        indexValue++;
                        
                        tail = [timelineView.layer.sublayers objectAtIndex:indexValue];
                        tail.borderColor = [NSColor purpleColor].CGColor;
                        tail.borderWidth = 2.0;
                        //next in array;
                        
                        // deselect head;
                        // move tail but must do error checking? or not something like generate new for tail?
                        
                        
                        
                        do {
                            moveLayer = [timelineView.layer.sublayers lastObject];
                            [moveLayer removeFromSuperlayer];
                            moveRect = [[timelineView.layer.sublayers objectAtIndex:0] frame];
                            moveRect.origin.x = moveRect.origin.x - moveRect.size.width;
                            moveLayer.frame = moveRect;
                            
                            [timelineView.layer insertSublayer:moveLayer atIndex:0];
                            
                        } while ([self testRectInView:moveRect]);
                        
                        /*
                        
                        for (int i = 0; i < 1; i++){
                            moveLayer = [timelineView.layer.sublayers lastObject];
                            [moveLayer removeFromSuperlayer];
                            moveRect = [[timelineView.layer.sublayers objectAtIndex:0] frame];
                            moveRect.origin.x = moveRect.origin.x - moveRect.size.width;
                            moveLayer.frame = moveRect;
                            
                            [timelineView.layer insertSublayer:moveLayer atIndex:0];
                        }
                        */
                        
                        head.borderWidth = 0;
                        head.borderColor = [NSColor clearColor].CGColor;
                        
                        // head is not in view, update head to next in line.
                        indexValue = [self layerIndexNearestViewLayerFrameOriginBoundry];
                        
                        
                        
                        
                        head = [timelineView.layer.sublayers objectAtIndex:indexValue];
                        head.borderColor = [NSColor blueColor].CGColor;
                        head.borderWidth = 2.0;
                        
                        
                        // need to make this a function where I do it, until I am clear of the sides
                        
                        
                        
                        
                        
                        /*
                        
                        moveLayer = [timelineView.layer.sublayers lastObject];
                        [moveLayer removeFromSuperlayer];
                        moveRect = [[timelineView.layer.sublayers objectAtIndex:0] frame];
                        moveRect.origin.x = moveRect.origin.x - moveRect.size.width;
                        moveLayer.frame = moveRect;
                        
                        [timelineView.layer insertSublayer:moveLayer atIndex:0];
                        
                        */
                        
                    }
                }
                
                 [CATransaction commit];

            }
        }
        
        mouseOldLocation.x = mouseDraggedLocation.x;
        mouseOldLocation.y = mouseDraggedLocation.y;
        //   } else if (NSPointInRect(timelineP, timelineView.bounds) && !timelineViewLock){
        //       NSLog(@"Point moving in timeline");
    }
    
}


-(float)selectedLayerPosition:(CGPoint) mousePreDragLocation With: (CGPoint) mousePostDragLocation And:(CGPoint) layerPosition
{
    float movementSign = mousePostDragLocation.x - layerPosition.x;
    float offsetSign   = mousePreDragLocation.x - layerPosition.x;
    float absOffset    = fabsf(offsetSign);
    float absMouseMovementDiff = fabsf(mousePostDragLocation.x - mousePreDragLocation.x);
    

    if (offsetSign < 0) {
        if (movementSign < 0) {
            return mousePostDragLocation.x + absOffset;
        } else if (movementSign > 0){
           return mousePreDragLocation.x + (mousePostDragLocation.x - mousePreDragLocation.x) + absOffset;
        }
    } else if (offsetSign > 0) {
        if (movementSign > 0){
            
            return (mousePostDragLocation.x - absOffset);
        } else if (movementSign < 0) {
            return mousePreDragLocation.x - (absMouseMovementDiff) + absOffset;
        }
    }
    
    return mousePostDragLocation.x;
 }

-(float)newPositionForAdjacentLayer:(CGPoint) selectedLayerOriginalPosition With: (CGPoint) selectedLayerNewPosition And: (CGPoint) adjacentLayerPosition
{
    float adjacentLayerSign = adjacentLayerPosition.x - selectedLayerOriginalPosition.x;
    float absAdjacentLayerDistance = fabsf(adjacentLayerSign);
    
    
    
    if (adjacentLayerSign < 0) {
        return selectedLayerNewPosition.x - absAdjacentLayerDistance;
    } else if (adjacentLayerSign > 0) {
        return selectedLayerNewPosition.x + absAdjacentLayerDistance;
    } else {
        NSLog(@"Something went horribly wrong here");
        
        return 0;
    }
}

-(void)generateTimelineViewLayers
{
    NSRect rect;
    
    
    
    self.view.layer.frame = self.view.frame;
    self.view.layer.backgroundColor = [NSColor purpleColor].CGColor;
    //self.view.layer.borderColor = [NSColor redColor].CGColor;
   // self.view.layer.borderWidth = 3.0;
    
    // first we need the size of the of the view's Layer:
    
    CGSize size = self.view.bounds.size;
    
    // Then we need to define the size of the layers:
    // At the moment make it so that there are 3 to the view and 2 on each side.
    size.width = (CGFloat)25;
    
    // As I decreen the width, I need more buffer on the sides.
    // set that to the "rect size" so that all the objects can be created.
    rect.origin = self.view.bounds.origin;
    rect.size = size;
    
    // HOnestly all this needs to be chopped off to a function
    // called generate timeline view layers
    
    SPCLayer * layer;
    CGFloat r, g, b;
    r= .07;
    g = .05;
    b = .03;
    
    int i = -2;
    
    do {
        rect.origin.x = (rect.size.width * i);
        layer = [[SPCLayer alloc]initWithIndex:i];
        layer.backgroundColor = [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0f].CGColor;
        layer.frame = rect;
       // layer.text.frame = rect;
        [self.view.layer addSublayer:layer];
        b = b + .03;
        g = g + .05;
        
        if (i == 0){
            head = layer;
            head.borderColor = [NSColor greenColor].CGColor;
            head.borderWidth = 0.7;
        }
        
        
        // Items: layer.frame, within a width of self.view.layer.frame.width
        
        if ([self rectIsNearWidthOfViewLayerFrame:layer.frame]) {
            tail = layer;
            tail.borderColor = [NSColor greenColor].CGColor;
            tail.borderWidth = 1.2;
        }
        i++;

    } while ((i < 0) || [self testRectInView:layer.frame]);
    
    // generate a couple more:
    
    for (int j = 0; j < 2; j++) {
        rect.origin.x = (rect.size.width * i);
        layer = [[SPCLayer alloc]initWithIndex:j];
        layer.backgroundColor = [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0f].CGColor;
        layer.frame = rect;
       // layer.text.frame = rect;
        [self.view.layer addSublayer:layer];
        b = b + .1;
        g = g + .05;
        
        if (i == 0){
            head = layer;
            head.borderColor = [NSColor greenColor].CGColor;
            head.borderWidth = 0.7;
        }
        
        
        // Items: layer.frame, within a width of self.view.layer.frame.width
        
        if ([self rectIsNearWidthOfViewLayerFrame:layer.frame]) {
            tail = layer;
            tail.borderColor = [NSColor greenColor].CGColor;
            tail.borderWidth = 1.2;
        }
        i++;

    }
    
    /*
    
    for (int i = -2; i <= 4; i++) {
        rect.origin.x = (rect.size.width * i);
        layer = [[SPCLayer alloc]initWithIndex:i];
        layer.backgroundColor = [NSColor colorWithCalibratedRed:r green:g blue:b alpha:1.0f].CGColor;
        layer.frame = rect;
        [self.view.layer addSublayer:layer];
        b = b + .1;
        g = g + .05;
        
        if (i == 0){
            head = layer;
            head.borderColor = [NSColor greenColor].CGColor;
            head.borderWidth = 0.7;
        }
        
        if (i == 2) {
            tail = layer;
            tail.borderColor = [NSColor greenColor].CGColor;
            tail.borderWidth = 1.2;
        }
        
    }
    */
    

}

-(BOOL)testRectInView:(NSRect)testRect
{
    BOOL origin = FALSE;
    BOOL frame  = FALSE;
    NSPoint testP;
    testP.x = testRect.origin.x + testRect.size.width;
    testP.y = testRect.origin.y + testRect.size.height -1; // don't worry about the Y here, bounds checking is inclucisve
                                 // 0...n   within if 0->n-1 not 0->n
    
    NSRect layer = timelineView.layer.bounds;
    
    
    origin = NSPointInRect(testRect.origin, timelineView.layer.bounds);
    frame = NSPointInRect(testP, timelineView.layer.bounds);
    
    if (origin || frame) {
        return true;
    } else {
        return false;
    }
        

            
            
}

-(BOOL)rectIsNearWidthOfViewLayerFrame:(NSRect)testRect {
    CGFloat testWidth = self.view.layer.frame.size.width;
    CGFloat widthDifference = testRect.origin.x - testWidth;
    
    widthDifference = fabsf(widthDifference);
    
    if (widthDifference <= testRect.size.width){
        return TRUE;
    } else {
        return FALSE;
    }
    
    
    
}

-(BOOL)rectIsNearOriginOfViewLayerFrame:(NSRect)testRect {
    CGFloat testWidth = testRect.size.width;
    CGFloat widthDifference = fabsf(testRect.origin.x) - testWidth;
    
    widthDifference = fabsf(widthDifference);
    
    if (widthDifference <= testRect.size.width){
        return TRUE;
    } else {
        return FALSE;
    }

}

-(NSUInteger )layerIndexNearestViewLayerFrameWidthBoundry{
    SPCLayer *testLayer = [self.view.layer.sublayers lastObject];
    CGRect testRect = testLayer.frame;
    NSUInteger indexOfLayer = [self.view.layer.sublayers count] - 1;
    
    
    while (![self rectIsNearWidthOfViewLayerFrame:testRect]) {
        indexOfLayer--;
        testLayer = [self.view.layer.sublayers objectAtIndex:indexOfLayer];
        testRect = testLayer.frame;
    }
    
    return indexOfLayer;
}

-(NSUInteger)layerIndexNearestViewLayerFrameOriginBoundry{
    SPCLayer *testLayer = [self.view.layer.sublayers firstObject];
    CGRect testRect = testLayer.frame;
    NSUInteger indexOfLayer = 0;
    
    while (![self rectIsNearOriginOfViewLayerFrame:testRect]) {
        indexOfLayer++;
        testLayer = [self.view.layer.sublayers objectAtIndex:indexOfLayer];
        testRect = testLayer.frame;
    }
    
    return indexOfLayer;

}

@end
