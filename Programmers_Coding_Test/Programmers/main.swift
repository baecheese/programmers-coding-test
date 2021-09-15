//
//  main.swift
//  Programmers
//
//  Created by 배지영 on 2021/08/06.
//

import Foundation

//["I 16","D 1"]    [0,0]
//["I 7","I 5","I -5","D -1"]    [7,5]
//print(double_priority(["I 16","D 1"]) == [0,0])
//print(double_priority(["I 7","I 5","I -5","D -1"]) == [7,5])

/*
"I -45"
"I 45"
"I 97"
 
 "D 1"
 "D 1"
 "D -1"
*/
print(double_priority(["I -45", "I 653", "D 1", "I -642", "I 45", "I 97", "D 1", "D -1", "I 333"]) == [333, -45])
