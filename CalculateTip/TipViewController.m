//
//  TipViewController.m
//  CalculateTip
//
//  Created by Patil, Sagar on 4/29/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
- (IBAction)ontap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onSegmentControlValueChange:(id)sender;
- (void) updateValues;
-(void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Tip";
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimer *timer1=[NSTimer timerWithTimeInterval:10.1 target:self selector:@selector(changeBackgroundColor) userInfo:nil repeats:YES];
    
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    [mainLoop addTimer:timer1 forMode:NSDefaultRunLoopMode];
    
    
    
    

    

}
CGFloat redValue;
CGFloat greenValue=255;
CGFloat blueValue;

-(void)changeBackgroundColor
{
    
//        int p=10;
//        CGFloat redValue = p<50 ? 255 : (256 - (p-50)*5.12);
//        CGFloat greenValue = p>50 ? 255 :((p)*5.12);
//        //CGFloat blueValue = 0;
//    redValue = 255;
//    greenValue=255;
//    
//   // CGFloat redValue = (arc4random() %255)/255.0f;
//     greenValue = (arc4random() %25)/25.0f;
    blueValue = (arc4random() %255)/255.0f;
    
    
    redValue = redValue + 5;
    greenValue = greenValue - redValue;
    if (redValue > 255) {
        redValue = 0;
        greenValue = 255;
        blueValue = 255;
    }
    
    //NSLog(@"Red : %.f  Green: %f  Blue:  %f",redValue,greenValue,blueValue);
    
    
    //self.view.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
  
}

- (void)viewWillAppear:(BOOL)animated {
       NSLog(@"viewMain will appear");
    //  retrieve saved values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float tip1 =[defaults floatForKey:@"tip1"];
    float tip2 =[defaults floatForKey:@"tip2"];
    float tip3 =[defaults floatForKey:@"tip3"];
    if (tip1 == 0.0 && tip2 ==0.0 && tip3 ==0.0) {
        tip1 =5.0;tip2=10.0;tip3=20.0;
    }
    NSString *strTip1= [NSString stringWithFormat:@"%.2f", tip1];
    NSString *strTip2= [NSString stringWithFormat:@"%.2f", tip2];
    NSString *strTip3= [NSString stringWithFormat:@"%.2f", tip3];
    
    NSLog(@"Tips %f  %f %f",tip1,tip2,tip3);
    
    //set values to the SegmentedControl
    [self.tipControl setTitle:strTip1 forSegmentAtIndex:0];
    [self.tipControl setTitle:strTip2 forSegmentAtIndex:1];
    [self.tipControl setTitle:strTip3 forSegmentAtIndex:2];

}

- (void)viewWillDisappear:(BOOL)animated {
  //  NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
  //  NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ontap:(id)sender {
       NSLog(@"HEre");
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues
{   float billAmount = [self.billTextField.text floatValue];
    
  

    NSString *strTip1 =  [self.tipControl titleForSegmentAtIndex:0];
      NSString *strTip2 =  [self.tipControl titleForSegmentAtIndex:1];
      NSString *strTip3 =  [self.tipControl titleForSegmentAtIndex:2];
//    NSLog(@"Segtitle :%@",str);
    float tip1, tip2, tip3;
    tip1 = [strTip1 floatValue];
    tip2 = [strTip2 floatValue];
    tip3 = [strTip3 floatValue];
    
    
    NSArray *tipValues = @[@(tip1),@(tip2),@(tip3)];
    
    float tipAmount = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue]/100;
    NSLog(@"Tip :%f",tipAmount);
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.amountLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
    
    
    
    
}

- (void)onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc]init] animated:YES];
}

- (IBAction)onSegmentControlValueChange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSString *val = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    NSLog(@"Current Tip value %@ ",val);
    [self updateValues];

}
@end
