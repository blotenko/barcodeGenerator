//
//  mainMenu.h
//  barcodeGenerator
//
//  Created by Blotenko on 09.05.2022.
//

#ifndef mainMenu_h
#define mainMenu_h


#import <UIKit/UIKit.h>

@interface mainMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) IBOutlet  UITableView* typeTableView;

@end


#endif /* mainMenu_h */
