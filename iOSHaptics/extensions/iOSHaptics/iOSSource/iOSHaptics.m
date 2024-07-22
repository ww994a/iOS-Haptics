#import "iOSHaptics.h"

@implementation iOSHaptics


- (instancetype)init {
    self = [super init];
    if (self) {
        [self createHapticEngine];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)createHapticEngine {
    self.hapticEngine = [[CHHapticEngine alloc] initAndReturnError:nil];
    
    [self.hapticEngine startWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to start haptic engine: %@", error.localizedDescription);
        }
    }];
}

- (void)applicationDidEnterBackground {
    [self.hapticEngine stopWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to stop haptic engine: %@", error.localizedDescription);
        }
    }];
}

- (void)applicationWillEnterForeground {
    [self.hapticEngine startWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to start haptic engine: %@", error.localizedDescription);
        }
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}


- (double)iOS_triggerVibration:(double)vibelength {
    if (!self.hapticEngine) {
        return (1);
    }

    NSError *error = nil;
    CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous
                                                          parameters:@[]
                                                       relativeTime:0.0
                                                           duration:vibelength]; // Adjust duration as needed

    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:@[event] parameters:@[] error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return (1);
    }
    
    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return (1);
    }
    
    [player startAtTime:0 error:&error];
    
    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}

- (double)iOS_triggerFanfareHaptic {
    if (!self.hapticEngine) {
        return 0.0;
    }

    NSError *error = nil;
    
    // Define haptic events for the fanfare pattern
    NSArray<CHHapticEvent *> *events = @[
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.0],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.1],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.2],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.3],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.4]
    ];
    
    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }
    
    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }
    
    [player startAtTime:0 error:&error];
    
    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}


- (double)iOS_triggerCustomHapticWithFirstVibration:(double)firstVibrationLength
                                                pause:(double)pauseLength
                                      secondVibration:(double)secondVibrationLength {
    if (!self.hapticEngine) {
        return 0.0;
    }

    NSError *error = nil;

    // Define haptic events for the custom pattern
    NSArray<CHHapticEvent *> *events = @[
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous
                                      parameters:@[]
                                    relativeTime:0.0
                                        duration:firstVibrationLength],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous
                                      parameters:@[]
                                    relativeTime:(firstVibrationLength + pauseLength)
                                        duration:secondVibrationLength]
    ];

    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];

    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }

    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];

    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }

    [player startAtTime:0 error:&error];

    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}

- (double)iOS_triggerTransient {
    if (!self.hapticEngine) {
        return 0.0;
    }

    NSError *error = nil;
    
    // Define a single haptic transient event
    NSArray<CHHapticEvent *> *events = @[
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:@[]
                                    relativeTime:0.0]
    ];
    
    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }
    
    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];
    
    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }
    
    [player startAtTime:0 error:&error];
    
    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}

- (double)iOS_triggerStrongTransient {
    if (!self.hapticEngine) {
        return 0.0;
    }

    NSError *error = nil;

    // Define a single strong haptic transient event with high intensity
    NSArray<CHHapticEventParameter *> *parameters = @[
        [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity
                                                      value:1.0],  // Maximum intensity
        [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness
                                                      value:1.0]   // Maximum sharpness
    ];
    
    NSArray<CHHapticEvent *> *events = @[
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:parameters
                                    relativeTime:0.0]
    ];

    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];

    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }

    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];

    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }

    [player startAtTime:0 error:&error];

    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}

- (double)iOS_triggerDoubleTransient {
    if (!self.hapticEngine) {
        return 0.0;
    }

    NSError *error = nil;
    
    // Define two haptic transient events
    NSArray<CHHapticEventParameter *> *parameters = @[
        [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity
                                                      value:1.0],  // Maximum intensity
        [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticSharpness
                                                      value:1.0]   // Maximum sharpness
    ];

    NSArray<CHHapticEvent *> *events = @[
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:parameters
                                    relativeTime:0.0],
        [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticTransient
                                      parameters:parameters
                                    relativeTime:0.1]
    ];

    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];

    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }

    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];

    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }

    [player startAtTime:0 error:&error];

    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}

- (double)iOS_triggerSwellWithLength:(double)length initialIntensity:(double)initialIntensity finalIntensity:(double)finalIntensity {
    if (!self.hapticEngine) {
        return 0.0;
    }

    // Clamp intensity values to the range [0.0, 1.0]
    initialIntensity = fmax(0.0, fmin(initialIntensity, 1.0));
    finalIntensity = fmax(0.0, fmin(finalIntensity, 1.0));

    NSError *error = nil;

    // Define step duration (for example, 0.1 seconds per step)
    double stepDuration = 0.1;
    int steps = (int)(length / stepDuration);

    // Ensure at least one step
    if (steps < 1) {
        steps = 1;
        stepDuration = length;
    }

    double intensityStep = (finalIntensity - initialIntensity) / steps;

    NSMutableArray<CHHapticEvent *> *events = [NSMutableArray array];

    for (int i = 0; i < steps; i++) {
        double currentIntensity = initialIntensity + intensityStep * i;
        CHHapticEventParameter *intensityParameter = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:currentIntensity];
        CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[intensityParameter] relativeTime:i * stepDuration duration:stepDuration];
        [events addObject:event];
    }

    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];

    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }

    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];

    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }

    [player startAtTime:0 error:&error];

    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}


- (double)iOS_triggerWaveWithLength:(double)length initialIntensity:(double)initialIntensity finalIntensity:(double)finalIntensity {
    if (!self.hapticEngine) {
        return 0.0;
    }

    // Clamp intensity values to the range [0.0, 1.0]
    initialIntensity = fmax(0.0, fmin(initialIntensity, 1.0));
    finalIntensity = fmax(0.0, fmin(finalIntensity, 1.0));

    NSError *error = nil;

    // Define step duration (for example, 0.1 seconds per step)
    double stepDuration = 0.1;
    int steps = (int)(length / stepDuration);

    // Ensure at least two steps to allow a wave pattern
    if (steps < 2) {
        steps = 2;
        stepDuration = length / 2;
    }

    double halfSteps = steps / 2;
    double intensityStepUp = (finalIntensity - initialIntensity) / halfSteps;
    double intensityStepDown = (finalIntensity - initialIntensity) / halfSteps;

    NSMutableArray<CHHapticEvent *> *events = [NSMutableArray array];

    // Create the swell up to the final intensity
    for (int i = 0; i < halfSteps; i++) {
        double currentIntensity = initialIntensity + intensityStepUp * i;
        CHHapticEventParameter *intensityParameter = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:currentIntensity];
        CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[intensityParameter] relativeTime:i * stepDuration duration:stepDuration];
        [events addObject:event];
    }

    // Create the swell down back to the initial intensity
    for (int i = 0; i < halfSteps; i++) {
        double currentIntensity = finalIntensity - intensityStepDown * i;
        CHHapticEventParameter *intensityParameter = [[CHHapticEventParameter alloc] initWithParameterID:CHHapticEventParameterIDHapticIntensity value:currentIntensity];
        CHHapticEvent *event = [[CHHapticEvent alloc] initWithEventType:CHHapticEventTypeHapticContinuous parameters:@[intensityParameter] relativeTime:(i + halfSteps) * stepDuration duration:stepDuration];
        [events addObject:event];
    }

    // Create a haptic pattern from the events
    CHHapticPattern *pattern = [[CHHapticPattern alloc] initWithEvents:events parameters:@[] error:&error];

    if (error) {
        NSLog(@"Failed to create haptic pattern: %@", error.localizedDescription);
        return 0.0;
    }

    id<CHHapticPatternPlayer> player = [self.hapticEngine createPlayerWithPattern:pattern error:&error];

    if (error) {
        NSLog(@"Failed to create haptic player: %@", error.localizedDescription);
        return 0.0;
    }

    [player startAtTime:0 error:&error];

    if (error) {
        NSLog(@"Failed to start haptic player: %@", error.localizedDescription);
    }
    return (1);
}


@end
