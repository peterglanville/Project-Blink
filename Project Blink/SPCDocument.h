//
//  SPCDocument.h
//  Project Blink
//
//  Created by Peter Glanville on 5/10/14.
//  Copyright (c) 2014 SparkCompiler. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SPCSceneViewController.h"
#import "SPCLedArray.h"

@interface SPCDocument : NSDocument {
    SPCLedArray *ledArray;
    
}

@property (assign) IBOutlet SPCSceneViewController *sceneViewController;
@property (assign) IBOutlet SPCTransparentWindowView *transparentWindowView;
@property (readwrite, retain) SPCLedArray *ledArray;


@end
