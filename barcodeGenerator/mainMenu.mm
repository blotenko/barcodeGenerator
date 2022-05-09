//
//  mainMenu.m
//  barcodeGenerator
//
//  Created by Blotenko on 09.05.2022.
//

#import "mainMenu.h"
#include "genImageToFile.hpp"


@interface mainMenuViewController ()
@property (strong) NSNumber* selectedType;
@property (strong) NSMutableDictionary* types;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIButton *generateButton;

@property (strong, nonatomic) IBOutlet UIImageView *imageBarcode;

@end

@implementation mainMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeTableView.delegate =self;
    self.typeTableView.dataSource=self;
    self.textField.delegate = (id)self;
  //  self.imageBarcode = [[UIImageView alloc] initWithFrame:CGRectMake(,0,200,200)];
    _imageBarcode.image =[UIImage imageNamed:@"White"];
    [self.view addSubview:_imageBarcode];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        cell.textLabel.text = @"Code 128";
    }
    else if(indexPath.row == 1){
        cell.textLabel.text = @"Code 39";
    }
    else if(indexPath.row == 2){
        cell.textLabel.text = @"QR code";
    }
    else if(indexPath.row == 3){
        cell.textLabel.text = @"ISBN 13";
    }
    else if(indexPath.row == 4){
        cell.textLabel.text = @"EAN 13";
    }
    
    NSNumber* TypeKey =  [NSNumber numberWithInteger: indexPath.row];
    if (self.selectedType
        && [TypeKey isEqualToNumber: self.selectedType])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedType = [NSNumber numberWithInteger: indexPath.row];
    self.textField.text = @"";
    [tableView reloadData];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.selectedType == 0) return NO;
    
return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.textField becomeFirstResponder];
    self.textField.text = @"" ;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
   // self.applyButton.enabled = NO;
    return NO;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.textField.endOfDocument;
    [self updateTextFeildControl];
    return YES;
}

- (void) updateTextFeildControl
{
    [_textField setTextAlignment: NSTextAlignmentCenter];
    //_textField.placeholder  = @"vlad blotenko";
}


-(NSString*)returnString
{
    return self.textField.text;
}

- (IBAction)generate:(id)sender {
    if(self.textField.text != @"EnterValue" && self.selectedType  !=0){
        
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.png"];

        std::string value = std::string([self.textField.text UTF8String]);
        std::string tmpPath = std::string([filePath UTF8String]);
        int type =  [self.selectedType intValue];
        createBarcodeImageByZint(tmpPath,value,type);
        id path = filePath;
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        self.imageBarcode.image = img;
        [self.view addSubview:_imageBarcode];
        
       
        
    }
}

\


@end
