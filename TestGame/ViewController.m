//
//  ViewController.m
//  TestGame
//
//  Created by Nouman Aslam on 06/07/2021.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@end

@implementation ViewController

- (UIButton *)tapButton
{
    if (!_tapButton) {
        _tapButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100 - 4, 4, 100, 30)];
        _tapButton.layer.cornerRadius = 5;
        _tapButton.backgroundColor = UIColor.blackColor;
       [ _tapButton setTitle:@"TAP" forState:UIControlStateNormal];
//        _tapButton.titleLabel.textColor = UIColor.whiteColor;
    }

    return _tapButton;
}

- (UISlider *)xSlider
{
    if (!_xSlider) {
        _xSlider = [[UISlider alloc] init];
        _xSlider.layer.masksToBounds = YES;
        _xSlider.layer.cornerRadius = 5;
        _xSlider.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _xSlider;
}

- (UISlider *)ySlider
{
    if (!_ySlider) {
        _ySlider = [[UISlider alloc] init];
        _ySlider.layer.masksToBounds = YES;
        _ySlider.layer.cornerRadius = 5;
        _ySlider.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _ySlider;
}

- (UISlider *)zSlider
{
    if (!_zSlider) {
        _zSlider = [[UISlider alloc] init];
        _zSlider.layer.masksToBounds = YES;
        _zSlider.layer.cornerRadius = 5;
        _zSlider.translatesAutoresizingMaskIntoConstraints = NO;
    }

    return _zSlider;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tapButton];
    [self.view addSubview:self.xSlider];
    [self.view addSubview:self.ySlider];
    [self.view addSubview:self.zSlider];
    
    CGFloat width = self.view.frame.size.width - 80;
    
    [[ self.ySlider.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor ] setActive:YES];
    [[ self.ySlider.widthAnchor constraintEqualToConstant: width ] setActive:YES];
    [[ self.ySlider.bottomAnchor constraintEqualToAnchor:self.xSlider.topAnchor constant:-10 ] setActive:YES];
    
    [[ self.xSlider.topAnchor constraintEqualToAnchor:self.ySlider.bottomAnchor constant:10 ] setActive:YES];
    [[ self.xSlider.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor ] setActive:YES];
    [[ self.xSlider.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor ] setActive:YES];
    [[ self.xSlider.widthAnchor constraintEqualToConstant: width ] setActive:YES];
    [[ self.xSlider.bottomAnchor constraintEqualToAnchor:self.zSlider.topAnchor constant:-10 ] setActive:YES];
    
    [[ self.zSlider.topAnchor constraintEqualToAnchor:self.xSlider.bottomAnchor constant:10] setActive:YES];
    [[ self.zSlider.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor ] setActive:YES];
    [[ self.zSlider.widthAnchor constraintEqualToConstant: width ] setActive:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self motionManager] stopAccelerometerUpdates];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startMotionDetection];
}

-(CMMotionManager *)motionManager
{
    CMMotionManager *motionMManager = nil;                                        //1
    id appDelegate = [[UIApplication sharedApplication] delegate];                //2
    if([appDelegate respondsToSelector:@selector(motionManager)]) {               //3
        motionMManager = [appDelegate motionManager];
    }
    return motionMManager;
}

-(void) startMotionDetection
{
    CMMotionManager *mManager = [self motionManager];                             //1
    [mManager setAccelerometerUpdateInterval:0.05];                               //2
    [mManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]     //3
                                   withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),^{                              //4
             [self updateMotionData:data];                                             //5
         });
     }
     ];
}

-(void) updateMotionData: (CMAccelerometerData *) data
{
    float moveFactor = 15;                                                        //1
    CGRect rect = _tapButton.frame;//2
    self.ySlider.value = data.acceleration.y;
    self.xSlider.value = data.acceleration.x;
    self.zSlider.value = data.acceleration.z;
    printf("%f", data.acceleration.y);
    printf("%f", data.acceleration.x);
    printf("%f", data.acceleration.z);
    float moveToX = rect.origin.x + (data.acceleration.x * moveFactor);           //3
    float moveToY = (rect.origin.y + rect.size.height) -(data.acceleration.y * moveFactor);
    float maxX = self.view.frame.size.width - rect.size.width;                    //5
    float maxY = self.view.frame.size.height;                                     //6
    if(moveToX > 0 && moveToX < maxX){                                            //7
        rect.origin.x += (data.acceleration.x * moveFactor);
    }
    if(moveToY > rect.size.height && moveToY < maxY){                             //8
        rect.origin.y -= (data.acceleration.y * moveFactor);
    }
    [UIView animateWithDuration:0 delay:0                                         //9
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ _tapButton.frame = rect; }
                     completion:nil];
   
    
}
@end
