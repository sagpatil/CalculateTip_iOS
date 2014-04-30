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
    NSTimer *timer1=[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeBackgroundColor) userInfo:nil repeats:YES];
    
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
    
    NSLog(@"Red : %.f  Green: %f  Blue:  %f",redValue,greenValue,blueValue);
    
    
    self.view.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ontap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues
{   float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
    float tipAmount = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.amountLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
}

- (void)onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc]init] animated:YES];
}

@end
