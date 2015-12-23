//
//  dispatch_q_t+Extension.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 23/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

extension dispatch_queue_t{
    
    func async( block: dispatch_block_t ){
        dispatch_async(self,block)
    }

}