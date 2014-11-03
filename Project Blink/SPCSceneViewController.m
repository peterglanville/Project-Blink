//
//  SPCSceneViewController.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 1/12/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import "SPCSceneViewController.h"
#import <SceneKit/SceneKit.h>



#define LED_DIST    10
#define degToRad(x) (M_PI * x / 180.0)
#define ROTATION_FACTOR 0.004



@interface SPCSceneViewController ()


@end

@implementation SPCSceneViewController

@synthesize camera;
@synthesize cameraNode;
@synthesize ledArrayNode;
@synthesize mouseDraggedLocation;
@synthesize mouseOriginalLocation;
@synthesize mouseDraggedOffset;
@synthesize angleX;
@synthesize angleY;
@synthesize initalLEDTransform;
@synthesize mouseOldLocation;
@synthesize lineLayer;
@synthesize pathForOutline;
@synthesize ledArray;

GLint items = -1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        clickedLEDName = @"";
        mouseOriginalLocation.x = 0;
        mouseOriginalLocation.y = 0;
        mouseDraggedLocation.x = 0;
        mouseDraggedLocation.y = 0;
        [self initializeVariablesAndWindow_ViewEnvironment];
        [self buildSceneAndImportLedArray];
        
        tracingLines = [[NSMutableArray alloc]init];
        
        
        
        self.view.nextResponder = self;
    }
    
    return self;
}



-(void)awakeFromNib
{
    
    
    
    
    tracingLines = [[NSMutableArray alloc]init];
    
    
    
    self.view.nextResponder = self;

    
}

-(void)mouseDown:(NSEvent *)theEvent
{

    //[self setView:sceneView];
   
   // [sceneView needsToDrawRect:sceneView.bounds];
    

     NSPoint winp    = [theEvent locationInWindow];
     NSPoint p       = [sceneView convertPoint:winp fromView:nil];
  //  NSPoint timelineP = [timelineView convertPoint:winp fromView:nil];
    
     if (NSPointInRect(p, sceneView.bounds)) {
         
         [self lockTimelineView];
        mouseOriginalLocation = p;
        mouseOldLocation = p;

         CGPoint p2      = CGPointMake(p.x, p.y);
         NSArray *pts    = [(SCNView *)sceneView hitTest:p2 options:@{}];


        SCNHitTestResult *result = [pts firstObject];


        // NSLog(@"%@ result items", result);

        if (result != NULL) {
            SCNNode *n = result.node;
            
            NSLog(@"node name == %@",n.name);
            clickedLEDName = [NSString stringWithString:n.name];
            
            // *** Fix the whole deal here. 
            
            for (SPCLedGeom *result in [ledArray ledArray]){
                
                if ([result.coordinateAttribute isEqualToString:clickedLEDName]) {\
                    [clickedLED setSelectionBoxInvisible];
                    if (clickedLED != Nil) {
                        [clickedLED setSelectionBoxInvisible];
                    }
                    clickedLED = result;
                   [result setSelectionBoxVisible];
                    
                    
                }
                
            }
            
            //[self determine2DOutlineOfLED:p2];
            
        } else {
            clickedLEDName = @"";
            //clickedLED = NULL;
            mouseOriginalLocation.x = p.x;
            mouseOriginalLocation.y = p.y;
            
        }

        // NSLog(@"%@", clickedLEDName);




        [sceneView setNeedsDisplay:YES];
 //    } else if (NSPointInRect(timelineP, timelineView.bounds)) {
  //       [self lockSceneView];
  //       NSLog(@"Point down in view");
     }
    

}


 -(void)mouseDragged:(NSEvent *)theEvent
{
    

    
    NSPoint winp    = [theEvent locationInWindow];
    NSPoint sceneP       = [sceneView convertPoint:winp fromView:nil];
  //  NSPoint timelineP    = [timelineView convertPoint:winp fromView:nil];
    
    
    
    //****************** TRANSFROM INIT ****************************************
    
    CATransform3D localProjectionTransform;
    CATransform3D translatedProjectionTransformX;
    CATransform3D translatedProjectionTransformY;
    CATransform3D translatedProjectionTransformFinal;
    
    CATransform3D rotatedProjectionTransformX;
    CATransform3D rotatedProjectionTransformY;
    CATransform3D rotatedProjectionTransformFinal;


    //****************** TRANSFROM INIT ****************************************

    
    if (NSPointInRect(sceneP, sceneView.bounds) && !sceneViewLock) {
        
        mouseDraggedLocation = sceneP;
    
        // Figure out Angle
        // Figure out percentages
        
        angleX = mouseDraggedLocation.x - mouseOldLocation.x;
        angleY = mouseDraggedLocation.y - mouseOldLocation.y;
        
        //********************************PLAYING WITH TRANSFORMS****************************
        
        //localProjectionTransform = ledArrayNode.transform;
        
        
        
        // X transform
        rotatedProjectionTransformX = CATransform3DMakeRotation(angleX * ROTATION_FACTOR, 0, -1, 0);
        // Y transform
        rotatedProjectionTransformY = CATransform3DMakeRotation(angleY * ROTATION_FACTOR, 0.0f, 0.0f, 1.0f);
        
        rotatedProjectionTransformFinal = CATransform3DConcat(rotatedProjectionTransformX, rotatedProjectionTransformY);
        
        translatedProjectionTransformX = CATransform3DMakeTranslation(0, angleX * ROTATION_FACTOR, 0);
        translatedProjectionTransformY = CATransform3DMakeTranslation( -1 *(angleY * ROTATION_FACTOR), 0, 0);
        translatedProjectionTransformFinal = CATransform3DConcat(translatedProjectionTransformX, translatedProjectionTransformY);
        

        localProjectionTransform = cameraRotationNode.transform;
        cameraRotationNode.transform = CATransform3DConcat(localProjectionTransform, rotatedProjectionTransformFinal);
        
       
        
        /*
        for (SCNNode *NodeTemp in [ledArrayNode childNodes]) {
            
                localProjectionTransform = NodeTemp.transform;
                NodeTemp.transform = CATransform3DConcat(localProjectionTransform, rotatedProjectionTransformFinal);
            
        }
        */
        

        //******************** Plane Rotation **************************************
      /*
        tempTransform = CATransform3DInvert(rotatedProjectionTransformY);
        //tempTransform = CATransform3DConcat(tempTransform, rotatedProjectionTransformY);
        
        for (SPCLedGeom *LEDTemp1 in LED_Array) {
            localProjectionTransform = LEDTemp1.LED_Outline_Plane_Node.transform;
            
           
            LEDTemp1.LED_Outline_Plane_Node.transform = CATransform3DConcat(localProjectionTransform, tempTransform);
        }
        */

        
        mouseOldLocation.x = mouseDraggedLocation.x;
        mouseOldLocation.y = mouseDraggedLocation.y;
 //   } else if (NSPointInRect(timelineP, timelineView.bounds) && !timelineViewLock){
 //       NSLog(@"Point moving in timeline");
    }

}


-(IBAction)changeLEDColor:(id)sender
{
    if (clickedLED != NULL){
        [clickedLED updateColor:[ledColorWell color]];
    }
}

- (void)printCATransform:(CATransform3D) transform
{

    
    NSLog(@"---------------------------------------------");
    NSLog(@"| m11:%f      m12:%f    m13:%f     m14:%f   |",transform.m11, transform.m12,transform.m13, transform.m14);
    NSLog(@"| m21:%f      m22:%f    m23:%f     m24:%f   |",transform.m21, transform.m22,transform.m23, transform.m24);
    NSLog(@"| m31:%f      m32:%f    m33:%f     m34:%f   |",transform.m31, transform.m32,transform.m33, transform.m34);
    NSLog(@"| m41:%f      m42:%f    m43:%f     m44:%f   |",transform.m41, transform.m42,transform.m43, transform.m44);
    NSLog(@"---------------------------------------------");
}





- (void)initializeVariablesAndWindow_ViewEnvironment
{
    //*********************** Window and OpenGL Initialization *************
    // Set the background for the window transparent to see the GLView.
        
    
    /*
     This is super fucking important!!
     This sets the OpenGL view behind the window. Now I need to cut a hole
     in the window the let it through.
     */
    
  // int windowVal = 1;
    
  // [sceneView.openGLContext setValues:&windowVal forParameter:NSOpenGLCPSurfaceOrder];
    
    //****************** END Window and OpenGL Initialization *************

    // Saving a pointer to the original view for later swapping
    
    _originalView = (SPCTransparentWindowView *)self.view;
    
    
    clickedLEDName = @"";
    
    sceneView.backgroundColor = [NSColor blueColor];
}


- (void)buildSceneAndImportLedArray
{
    // Create the scene and get the root
    sceneView.scene = [SCNScene scene];
    root = sceneView.scene.rootNode;
    
    
    SCNLookAtConstraint *lookAt;
    lookAt = [SCNLookAtConstraint lookAtConstraintWithTarget:root];
    lookAt.gimbalLockEnabled = YES;
    
    // Create a camera
    cameraRotationNode = [SCNNode node];
    cameraRotationNode.name = @"Camera Rotation Node";
    [root addChildNode:cameraRotationNode];
    
    camera = [SCNCamera camera];
    camera.xFov = 45;   // Degrees, not radians
    camera.yFov = 45;
    camera.name = @"Camera";
	cameraNode = [SCNNode node];
    cameraNode.name = @"Camera Node";
	cameraNode.camera = camera;
	cameraNode.position = SCNVector3Make(-60, 0, 0);
    cameraNode.constraints = @[lookAt];
    
    [cameraRotationNode addChildNode:cameraNode];
    
    
    // All LEDs are under this Node. For Camera Movement purposes.
    //
    //
    //              rootNode
    //           /           \
    // cameraRotationNode     ledArrayNode
    //         /
    //     cameraNode
    //      /              /        \
    //    camera        ledNode    ledNode
    //
    //
    //
    
    
    [root addChildNode:[ledArray ledArrayNode]];
    
    // Create ambient light
    SCNLight *ambientLight = [SCNLight light];
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLight.type = SCNLightTypeAmbient;
    ambientLight.color = [NSColor colorWithDeviceWhite:0.1 alpha:1.0];
    ambientLightNode.light = ambientLight;
    [root addChildNode:ambientLightNode];
    
    // Create a diffuse light
    SCNLight *diffuseLight = [SCNLight light];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
    diffuseLightNode.position = SCNVector3Make(-30, 30, 50);
    [root addChildNode:diffuseLightNode];

}

-(void)lockSceneView
{
    sceneViewLock = YES;
    timelineViewLock = NO;
}

-(void)lockTimelineView
{
    sceneViewLock = NO;
    timelineViewLock = YES;
}






@end
