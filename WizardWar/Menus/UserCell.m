//
//  UserCell.m
//  WizardWar
//
//  Created by Sean Hess on 7/8/13.
//  Copyright (c) 2013 The LAB. All rights reserved.
//

#import "UserCell.h"
#import "LocationService.h"
#import "ChallengeService.h"
#import "UIColor+Hex.h"

@interface UserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@end

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(User *)user {
    _user = user;
    
    self.nameLabel.text = user.name;
    
    if (user.isOnline)
        self.nameLabel.textColor = [UIColor colorFromRGB:0x81B23C];
    else
        self.nameLabel.textColor = [UIColor darkTextColor];
    
//    self.avatarImageView.image = [UIImage imageNamed:@"user.jpg"];

    if (user.isFriend)
        self.typeLabel.text = @"FRENEMY";
    else
        self.typeLabel.text = @"LOCAL";
    
    NSString * games = [NSString stringWithFormat:@"%i Games", user.friendPoints];
    NSString * distance = @"";
    
    if (user.isOnline && user.distance >= 0) {
        distance = [NSString stringWithFormat:@"%@, ", [LocationService.shared distanceString:user.distance]];
    }
    
    self.otherLabel.text = [NSString stringWithFormat:@"%@%@", distance, games];
    
    if (user.activeMatchId) {
        Challenge * challenge = [ChallengeService.shared challengeWithId:user.activeMatchId create:NO];
        if (!challenge) {
            NSLog(@"****NO CHALLENGE %@", user.activeMatchId);
            return;
        }
        User * opponent = [challenge findOpponent:user];
        self.otherLabel.text = [NSString stringWithFormat:@"FIGHTING %@!", opponent.name];
    }
}

-(void)reloadFromUser {
    self.user = self.user;
}

@end