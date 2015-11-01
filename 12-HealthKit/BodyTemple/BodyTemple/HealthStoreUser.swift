//
//  HealthStoreUser.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthStoreUser:class{
    var healthStore:HKHealthStore? {get set}
}
