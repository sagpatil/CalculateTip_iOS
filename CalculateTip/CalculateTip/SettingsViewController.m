//
//  SettingsViewController.m
//  CalculateTip
//
//  Created by Patil, Sagar on 4/29/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

- (IBAction)onTapSettings:(id)sender;
- (void)saveValues;
@property (weak, nonatomic) IBOutlet UITextField *tip1TextField;
@property (weak, nonatomic) IBOutlet UITextField *tip2TextField;
@property (weak, nonatomic) IBOutlet UITextField *tip3TextField;
- (IBAction)onTipTextFieldTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *tip1Switch;
@property (weak, nonatomic) IBOutlet UISwitch *tip2Switch;
@property (weak, nonatomic) IBOutlet UISwitch *tip3Switch;
- (IBAction)onSwitchTouched:(id)sender;

@end

int thisSwitchOn;
@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  retrieve saved values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float tip1 =[defaults floatForKey:@"tip1"];
    float tip2 =[defaults floatForKey:@"tip2"];
    float tip3 =[defaults floatForKey:@"tip3"];
    
    if (tip1 == 0.0 && tip2 ==0.0 && tip3 ==0.0) {
        tip1 =5.0;tip2=10.0;tip3=20.0;
    }
    
    thisSwitchOn=[defaults integerForKey:@"switch"];
    self.tip1TextField.text = [NSString stringWithFormat:@"%.2f", tip1];
    self.tip2TextField.text = [NSString stringWithFormat:@"%.2f", tip2];
    self.tip3TextField.text = [NSString stringWithFormat:@"%.2f", tip3];
    switch (thisSwitchOn) {
        case 0:
            self.tip1Switch.on = YES;
            break;
        case 1:
            self.tip2Switch.on = YES;
            break;
        case 2:
            self.tip3Switch.on = YES;
            break;
        default:
            break;
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
      NSLog(@"Back to Tips button clicked");
     [self saveValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTapSettings:(id)sender {
 
    [self.view endEditing:YES];
    [self saveValues];
    
}

// completed saving values
- (void)saveValues{
    float tip1 = [self.tip1TextField.text floatValue];
    float tip2 = [self.tip2TextField.text floatValue];
    float tip3 = [self.tip3TextField.text floatValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:tip1 forKey:@"tip1"];
    [defaults setFloat:tip2 forKey:@"tip2"];
    [defaults setFloat:tip3 forKey:@"tip3"];
    [defaults setInteger:thisSwitchOn forKey:@"switch"];
    [defaults synchronize];
}

//Clear the text when CLicked
- (IBAction)onTipTextFieldTouched:(id)sender {
    UITextField *tf = (UITextField *)sender;
    tf.text = @"";
}


- (IBAction)onSwitchTouched:(id)sender {
    
    UISwitch* theSwitch = (UISwitch*) sender;
    BOOL theSwitchIsOn = theSwitch.on;
    NSLog(@"Switch %d",theSwitchIsOn);
    
    if (sender == self.tip1Switch && self.tip1Switch.on==YES) {
        NSLog(@"Switch 1 touched");
        self.tip2Switch.on=NO;
        self.tip3Switch.on=NO;
        thisSwitchOn=0;
        
    }else if (sender == self.tip2Switch && self.tip2Switch.on==YES){
         NSLog(@"Switch 2 touched");
        self.tip1Switch.on=NO;
        self.tip3Switch.on=NO;
        thisSwitchOn=1;
        
    }else if(sender == self.tip3Switch && self.tip3Switch.on==YES)
    {
        NSLog(@"Switch 3 touched");
        self.tip1Switch.on=NO;
        self.tip2Switch.on=NO;
        thisSwitchOn=2;
    }
    
    if (self.tip3Switch.on==NO && self.tip2Switch.on==NO && self.tip1Switch.on==NO) {
        self.tip1Switch.on=YES;
        thisSwitchOn=0;
    }
}
@end
