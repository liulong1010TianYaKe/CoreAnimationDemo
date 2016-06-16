//
//  DrawingRectView.m
//  TimeAnimation-15
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "DrawingRectView.h"
#define BRUSH_SIZE 32
@interface DrawingRectView ()
@property (nonatomic, strong) NSMutableArray *strokes;
@end

@implementation DrawingRectView

- (void)awakeFromNib{
    self.backgroundColor = [UIColor blackColor];
}

- (NSMutableArray *)strokes{
    if (!_strokes) {
        _strokes = [NSMutableArray array];
    }
    return _strokes;
}


//- (void)addBrushStrokeAtPoint:(CGPoint)point{
//    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
//    [self setNeedsDisplay];
//}

- (void)addBrushStrokeAtPoint:(CGPoint)point{
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    // set dirty rect
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)drawRect:(CGRect)rect{
    
    for (NSValue *value in self.strokes ) {
        CGPoint point = [value CGPointValue];
//        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
//        //draw brush stroke
//        [[UIImage imageNamed:@"chalk"] drawInRect:brushRect];
        
        CGRect brushRect = [self brushRectForPoint:point];
        if (CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"chalk"] drawInRect:brushRect];
        }
    }
}
@end
