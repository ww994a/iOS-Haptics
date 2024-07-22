#ifndef iOSHaptics_h
#define iOSHaptics_h

#import <UIKit/UIKit.h>
#import <CoreHaptics/CoreHaptics.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface iOSHaptics : NSObject
{
    NSString *VarPath;
}

@property (nonatomic, strong) CHHapticEngine *hapticEngine;


-(double)iOS_triggerVibration:(double)vibelength;
-(double)iOS_triggerCustomHapticWithFirstVibration:(double)firstVibrationLength
                                               pause:(double)pauseLength
                                     secondVibration:(double)secondVibrationLength;
-(double)iOS_triggerFanfareHaptic;
-(double)iOS_triggerTransient;
- (double)iOS_triggerStrongTransient;
- (double)iOS_triggerDoubleTransient;
- (double)iOS_triggerSwellWithLength:(double)length initialIntensity:(double)initialIntensity finalIntensity:(double)finalIntensity;
- (double)iOS_triggerWaveWithLength:(double)length initialIntensity:(double)initialIntensity finalIntensity:(double)finalIntensity; 


@end

#endif /* iOSHaptics_h */
