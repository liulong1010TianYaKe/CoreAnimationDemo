//
//  main.m
//  CutImageDemo
//
//  Created by long on 6/13/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSImage;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (argc < 2) {
            NSLog(@"TileCutter arguments: Inputfile");
            return 0;
        }
        
        // input file
        NSString *inputFile = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        //tile size
        CGFloat tileSize = 256; //output path
        NSString *outputPath = [inputFile stringByDeletingPathExtension];
        //load imag
        
    }
    
    return 0;
}
