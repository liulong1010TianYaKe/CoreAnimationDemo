//
//  Bounce.c
//  TimeAnimation-15
//
//  Created by long on 6/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#include "Bounce.h"


float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}


float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}