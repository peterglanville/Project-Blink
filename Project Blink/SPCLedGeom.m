//
//  SPCLedGeom.m
//  SceneKit_Examples
//
//  Created by Peter Glanville on 1/6/14.
//  Copyright (c) 2014 Spark Compiler. All rights reserved.
//
#define TRANSPARENCY_LEVEL 1.0
#define CYLINDER_RADIUS    2.0
#define CYLINDER_HEIGHT    3.0
#define degToRad(x) (M_PI * x / 180.0)
#import "SPCLedGeom.h"


@implementation SPCLedGeom
@synthesize     LED_Cylinder;
@synthesize     LED_Lip;
@synthesize     LED_Cap;
@synthesize     LED_Outline_Plane;


@synthesize     LED_Cylinder_Node;
@synthesize     LED_Lip_Node;
@synthesize     LED_Cap_Node;
@synthesize     LEDGeomNode;

@synthesize     LED_Cylinder_Transform;
@synthesize     LED_Lip_Transform;
@synthesize     LED_Cap_Transform;


@synthesize material;
@synthesize sphereMaterial;
@synthesize cylinderMaterial;

@synthesize sphereOpacityImage;
@synthesize cylinderOpacityImage;

@synthesize coordinateAttribute;


-(id)init {
    
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}



- (id)initWithOffsetX:(float)x with_Y:(float)y with_Z:(float)z and_Name:(NSString*)name {
    self = [super init];
    if (self) {
        
        //Init Items that will need to be used elsewhere:
        selectionBoxArray = [[NSMutableArray alloc]init];
        
        
        
        material = [SCNMaterial material];
        material.transparency = TRANSPARENCY_LEVEL;
        //material.diffuse.contents = [NSColor blueColor];
        /*
        outlinePlaneMaterial = [SCNMaterial material];
        outlinePlaneMaterial.transparency = TRANSPARENCY_LEVEL;
        outlinePlaneMaterial.doubleSided = TRUE;
        */
        
        sphereMaterial = [SCNMaterial material];
        //sphereOpacityImage = [NSImage imageNamed:@"BW"];
        //sphereMaterial.transparent.contents = sphereOpacityImage;
        sphereMaterial.transparency = TRANSPARENCY_LEVEL;
        
        cylinderMaterial = [SCNMaterial material];
        //cylinderOpacityImage = [NSImage imageNamed:@"Cylinder_BW"];
        //cylinderMaterial.transparent.contents = cylinderOpacityImage;
        cylinderMaterial.transparency = TRANSPARENCY_LEVEL;
        
        
        
        LED_Cylinder = [SCNCylinder cylinderWithRadius:CYLINDER_RADIUS height:CYLINDER_HEIGHT];
        LED_Cylinder.materials = @[cylinderMaterial];
        LED_Cylinder_Node = [SCNNode nodeWithGeometry:LED_Cylinder];
        LED_Cylinder_Transform = CATransform3DMakeTranslation(0, 0, 0);
        LED_Cylinder_Node.transform = LED_Cylinder_Transform;
        
        
        LED_Lip = [SCNCylinder cylinderWithRadius:2.5 height:0.5];
        LED_Lip.materials = @[material];
        LED_Lip_Node = [SCNNode nodeWithGeometry:LED_Lip];
        LED_Lip_Transform = CATransform3DMakeTranslation(0, -1.5, 0);
        LED_Lip_Node.transform = LED_Lip_Transform;
        
        LED_Cap = [SCNSphere sphereWithRadius:2.0];
        LED_Cap.materials = @[material];
        LED_Cap_Node = [SCNNode nodeWithGeometry:LED_Cap];
        LED_Cap_Transform = CATransform3DMakeTranslation(0, 1.5, 0);
        LED_Cap_Node.transform = LED_Cap_Transform;
        
        
        // r * sqrt2
        
       
        
        /*
        
        LED_Outline_Plane = [SCNPlane planeWithWidth:8 height:8];
        LED_Outline_Plane.materials = @[outlinePlaneMaterial];
        LED_Outline_Plane_Node = [SCNNode nodeWithGeometry:LED_Outline_Plane];
        LED_Outline_Plane_Transform = CATransform3DMakeTranslation(0,0,0);
        LED_Outline_Plane_Node.transform = LED_Outline_Plane_Transform;
        */
        LEDGeomNode = [[SCNNode alloc]init];
        LEDGeomNode.transform = CATransform3DMakeTranslation(x, y, z);
        /*
        LEDOutlinePoisitionNode = [[SCNNode alloc]init];
        LEDOutlinePoisitionNode.transform = CATransform3DMakeTranslation(x, y, z);
        */
        coordinateAttribute = [NSString stringWithString:name];
        LED_Cylinder_Node.name = coordinateAttribute;
        LED_Lip_Node.name = coordinateAttribute;
        LED_Cap_Node.name = coordinateAttribute;
        //LED_Outline_Plane_Node.name = [NSString stringWithFormat:@"O + %@",coordinateAttribute];
        LEDGeomNode.name  = coordinateAttribute;
        
       // LEDOutlinePoisitionNode.name = [NSString stringWithFormat:@"O + %@",coordinateAttribute];
        
         [self generateSelectionBox];
        
        
        
        
        /*
         
         
        
        capsuleMaterial = [SCNMaterial material];
        //capsuleOpacityImage = [NSImage imageNamed:@"Cylinder_BW"];
        //capsuleMaterial.transparent.contents = capsuleOpacityImage;
        capsuleMaterial.transparency = 1.0;
        
        
        
        LED_Capsule = [SCNCapsule capsuleWithCapRadius:2.0 height:3.0];
        LED_Capsule.materials = @[capsuleMaterial];
        LED_Capsule_Node = [SCNNode nodeWithGeometry:LED_Capsule];
        LED_Capsule_Transform = CATransform3DMakeTranslation(0+x, 1.5+y, 0+z);
        LED_Capsule_Node.transform = LED_Capsule_Transform;
        LED_Capsule_Node.name = coordinateAttribute;
         
         */
    }
    return self;
}

- (void)addLedToRootNode:(SCNNode *)node {
    
    //[node addChildNode:LEDOutlinePoisitionNode];
    [node addChildNode:LEDGeomNode];
    
    [LEDGeomNode addChildNode:LED_Cylinder_Node];
    [LEDGeomNode addChildNode:LED_Cap_Node];
    [LEDGeomNode addChildNode:LED_Lip_Node];
    
    for (SCNNode *boxNode in selectionBoxArray) {
        [LEDGeomNode addChildNode:boxNode];
    }
    
    
    //[LEDGeomNode addChildNode:LED_Outline_Plane_Node];
    //[scene.rootNode addChildNode:LED_Capsule_Node];
}

- (void)updateColor:(NSColor *) color
{
    material.diffuse.contents = color;
    sphereMaterial.diffuse.contents = color;
    cylinderMaterial.diffuse.contents = color;
}

- (void)generateSelectionBox
{
    
    // I think I can do this with a mutable array of SCNBox objects, generate and spit out.
    // That way I can play with the notions and items as I see fit.
    // OK thats a thing Ill do
    
    // 45 degrees * radians in X axis
    CATransform3D offAxis45Degrees = CATransform3DMakeRotation(degToRad(45), 0, 1, 0);
   // CATransform3D translationOffsetBox2 = CATransform3DMakeTranslation(0, .25, 0);
    
    
    SCNBox *arrayBox;
    SCNNode *arrayBoxNode;
    SCNMaterial *arrayBoxMaterial;
    
    arrayBoxMaterial = [SCNMaterial material];
    arrayBoxMaterial.transparency = 0;
    arrayBoxMaterial.diffuse.contents = [NSColor blackColor];
    
    
    for (int i = -4 ; i <= 5; i++){
        arrayBox = [SCNBox boxWithWidth:CYLINDER_RADIUS+0.9 height:CYLINDER_HEIGHT/6 length:CYLINDER_RADIUS+1.2 chamferRadius:.2];
        
        arrayBox.materials = @[arrayBoxMaterial];
        
        arrayBoxNode = [SCNNode nodeWithGeometry:arrayBox];
        
        
        if ( i%2 == 0) {
            arrayBoxNode.transform = CATransform3DConcat(offAxis45Degrees, CATransform3DMakeTranslation(0, i * .35, 0));
        } else {
            arrayBoxNode.transform = CATransform3DMakeTranslation(0, i * .35, 0);
        }
        
        arrayBox.name = coordinateAttribute;
        arrayBoxNode.name = coordinateAttribute;
        
        [selectionBoxArray addObject:arrayBoxNode];
    }
    
   
    
    /*
    for (int i = 6; i <= 9; i++){
        
         radiusOfSmallCircle = sqrt((2*2)-(((i-4)*.35)*((i-4)*.35)));
        NSLog(@"radius of small circule %f",radiusOfSmallCircle);
        
        arrayBox = [SCNBox boxWithWidth:(radiusOfSmallCircle+.7) height:CYLINDER_HEIGHT/6 length:(radiusOfSmallCircle+.7) chamferRadius:.2];
        
        arrayBox.materials = @[arrayBoxMaterial];
        
        arrayBoxNode = [SCNNode nodeWithGeometry:arrayBox];
        
        
        if ( i%2 == 0) {
            arrayBoxNode.transform = CATransform3DConcat(offAxis45Degrees, CATransform3DMakeTranslation(0, i * .35, 0));
        } else {
            arrayBoxNode.transform = CATransform3DMakeTranslation(0, i * .35, 0);
        }
        
        arrayBox.name = coordinateAttribute;
        arrayBoxNode.name = coordinateAttribute;
        
        [selectionBoxArray addObject:arrayBoxNode];
    }
    */
    // Need to manually do 6,7,8,9,10  or so.UGH I am going to leave this for now. Ill come back to it soon.
    
    
    
}




- (void)setSelectionBoxVisible
{
    NSArray *boxMaterials;
    for (SCNNode *boxNode in selectionBoxArray){
        boxMaterials = boxNode.geometry.materials;
        for (SCNMaterial *boxMaterial in boxMaterials) {
            boxMaterial.transparency = 0.5;
        }
    }
}

-(void)setSelectionBoxInvisible
{
    NSArray *boxMaterials;
    for (SCNNode *boxNode in selectionBoxArray){
        boxMaterials = boxNode.geometry.materials;
        for (SCNMaterial *boxMaterial in boxMaterials) {
            boxMaterial.transparency = 0.0;
        }
    }

}

@end
