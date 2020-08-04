//
//  Routine.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 8/4/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation
import RealmSwift

class Routine: Object{
    @objc dynamic var exerciseList: [String] = []
    @objc dynamic var name: String?
}
