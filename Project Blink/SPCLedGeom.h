//
//  SPCLedGeom.h
//  SceneKit_Examples
//
//  Created by Peter Glanville on 1/6/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface SPCLedGeom : NSObject {
    SCNCylinder *LED_Cylinder;
    SCNCylinder *LED_Lip;
    SCNSphere   *LED_Cap;
    //SCNPlane    *LED_Outline_Plane;
    
    SCNNode     *LED_Cylinder_Node;
    SCNNode     *LED_Lip_Node;
    SCNNode     *LED_Cap_Node;
   // SCNNode     *LED_Outline_Plane_Node;
    SCNNode     *LEDGeomNode;
   // SCNNode     *LEDOutlinePoisitionNode;
    
    // This is the place where I play with a capsule.
    /*
    
    SCNCapsule *LED_Capsule;
    SCNNode     *LED_Capsule_Node;
    CATransform3D   LED_Capsule_Transform;
    SCNMaterial *capsuleMaterial;
    NSImage *capsuleOpacityImage;
    
     */
    // End the place where I play with a capsule.
    
    CATransform3D     LED_Cylinder_Transform;
    CATransform3D     LED_Lip_Transform;
    CATransform3D     LED_Cap_Transform;
   // CATransform3D     LED_Outline_Plane_Transform;
   // CATransform3D       LEDGeomTransform;
   // CATransform3D       LEDOutlinePositionNodeTransform;
    
    SCNMaterial *material;
    SCNMaterial *sphereMaterial;
    SCNMaterial *cylinderMaterial;
    SCNMaterial *outlinePlaneMaterial;
    
    NSString *coordinateAttribute;
    
    
    NSImage *sphereOpacityImage;
    NSImage *cylinderOpacityImage;
    
    
    
    // Selection Box Area
    
    NSMutableArray *selectionBoxArray;
    
    //Create the Box
    SCNNode *selectionBoxNode;
    SCNBox  *selectionBox;
    CATransform3D selectionBoxTransform;
    SCNMaterial *selectionBoxMaterial;
    
    
    //Create Box 2
    SCNNode *selectionBoxNode2;
    SCNBox  *selectionBox2;
    CATransform3D selectionBoxTransform2;
    SCNMaterial *selectionBoxMaterial2;
    
    
    
    
}

@property (readwrite, copy) SCNCylinder *LED_Cylinder;
@property (readwrite, copy)SCNCylinder *LED_Lip;
@property (readwrite, copy)SCNSphere   *LED_Cap;
@property (readwrite, copy)SCNPlane    *LED_Outline_Plane;

@property (readwrite, copy)SCNNode     *LED_Cylinder_Node;
@property (readwrite, copy)SCNNode     *LED_Lip_Node;
@property (readwrite, copy)SCNNode     *LED_Cap_Node;
//@property (readwrite, copy)SCNNode     *LED_Outline_Plane_Node;
@property (readwrite, copy)SCNNode      *LEDGeomNode;
//@property (readwrite, copy)SCNNode      *LEDOutlinePositionNode;

@property (readwrite)CATransform3D     LED_Cylinder_Transform;
@property (readwrite)CATransform3D     LED_Lip_Transform;
@property (readwrite)CATransform3D     LED_Cap_Transform;
//@property (readwrite)CATransform3D      LED_Outline_Plane_Transform;

@property (readwrite, copy)SCNMaterial *material;
@property (readwrite, copy)SCNMaterial *sphereMaterial;
@property (readwrite, copy)SCNMaterial *cylinderMaterial;
//@property (readwrite, copy)SCNMaterial *outlinePlaneMaterial;

@property (readwrite, copy)NSImage  *sphereOpacityImage;
@property (readwrite, copy)NSImage  *cylinderOpacityImage;

@property (readwrite, copy)NSString *coordinateAttribute;





// PLace for capsule stuff

@property (readwrite, copy)SCNCapsule      *LED_Capsule;
@property (readwrite, copy)SCNNode     *LED_Capsule_Node;
@property (readwrite)CATransform3D   LED_Capsule_Transform;
@property (readwrite, copy)SCNMaterial *capsuleMaterial;
@property (readwrite, copy)NSImage *capsuleOpacityImage;

// No more capsule stuff.

// Selection Box Nonsense
@property (readwrite, copy)NSMutableArray *selectionBoxArray;

- (void)addLedToRootNode:(SCNNode *)node;
- (id)initWithOffsetX:(float)x with_Y:(float)y with_Z:(float)z and_Name:(NSString *)name;
- (void)updateColor:(NSColor *) color;
- (void)generateSelectionBox;
- (void)setSelectionBoxVisible;
- (void)setSelectionBoxInvisible;
@end
