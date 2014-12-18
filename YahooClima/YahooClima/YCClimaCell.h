//
//  YCClimaCell.h
//  YahooClima
//
//  Created by Apocalapsus on 12/18/14.
//  Copyright (c) 2014 Jaguar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCClimaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ciudadLbl;
@property (weak, nonatomic) IBOutlet UILabel *oweidLbl;
@property (weak, nonatomic) IBOutlet UILabel *pronosticoLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;

@end
