//
// 다리를지나는트럭.swift
//  Programmers
//
//  Created by 배지영 on 2021/08/06.
//

import Foundation
/*
 문제 설명
 트럭 여러 대가 강을 가로지르는 일차선 다리를 정해진 순으로 건너려 합니다. 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 알아내야 합니다. 다리에는 트럭이 최대 bridge_length대 올라갈 수 있으며, 다리는 weight 이하까지의 무게를 견딜 수 있습니다. 단, 다리에 완전히 오르지 않은 트럭의 무게는 무시합니다.

 예를 들어, 트럭 2대가 올라갈 수 있고 무게를 10kg까지 견디는 다리가 있습니다. 무게가 [7, 4, 5, 6]kg인 트럭이 순서대로 최단 시간 안에 다리를 건너려면 다음과 같이 건너야 합니다.

 경과 시간    다리를 지난 트럭    다리를 건너는 트럭    대기 트럭
 0    []    []    [7,4,5,6]
 1~2    []    [7]    [4,5,6]
 3    [7]    [4]    [5,6]
 4    [7]    [4,5]    [6]
 5    [7,4]    [5]    [6]
 6~7    [7,4,5]    [6]    []
 8    [7,4,5,6]    []    []
 따라서, 모든 트럭이 다리를 지나려면 최소 8초가 걸립니다.

 solution 함수의 매개변수로 다리에 올라갈 수 있는 트럭 수 bridge_length, 다리가 견딜 수 있는 무게 weight, 트럭 별 무게 truck_weights가 주어집니다. 이때 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 return 하도록 solution 함수를 완성하세요.

 제한 조건
 bridge_length는 1 이상 10,000 이하입니다.
 weight는 1 이상 10,000 이하입니다.
 truck_weights의 길이는 1 이상 10,000 이하입니다.
 모든 트럭의 무게는 1 이상 weight 이하입니다.
 입출력 예
 bridge_length    weight    truck_weights    return
 2    10    [7,4,5,6]    8
 100    100    [10]    101
 100    100    [10,10,10,10,10,10,10,10,10,10]    110
 출처

 ※ 공지 - 2020년 4월 06일 테스트케이스가 추가되었습니다.
 */

// ** 트럭은 1초에 1길이씩 움직일 수 있다. (문제에 설명이 누락되어있음)
// ** 트럭하나가 다리가 버틸수 있는 최대 무게보다 적다는 전제가 있어야 할듯
func crossBridgeTruck(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    let bridget = Bridge(length: bridge_length, maxWeight: weight)
    let trucks = truck_weights.map { Truck(weight: $0) }
    return bridget.cross(trucks: trucks)
}

class Truck {
    let weight: Int
    private var current_state: State = .ready
    private var location: Int = 0
    
    var state: State {
        return current_state
    }
    
    enum State {
        case ready
        case doing
        case done
    }
    
    init(weight: Int) {
        self.weight = weight
    }
    
    func move(on bridge: Bridge, secound: Int) {
        self.current_state = .doing
        location += secound
        if bridge.length < location {
            self.current_state = .done
        }
    }
}

class Bridge {
    var maxCount: Int
    var maxWeight: Int
    
    var length: Int {
        return maxCount
    }
    
    // 현재 가능한 무게
    var acceptableWeight: Int {
        return maxWeight - crossing.reduce(0) { $0 + $1.weight }
    }
    
    private var crossing: [Truck] = []
    private var isOpen: Bool = false
    
    init(length: Int, maxWeight: Int) {
        self.maxCount = length
        self.maxWeight = maxWeight
    }
    
    func cross(trucks: [Truck]) -> Int {
        guard false == trucks.isEmpty else { return 0 }
        var queue = trucks
        var timer: Int = 0
        while false == queue.isEmpty || false == crossing.isEmpty {
            timer += 1
            if false == crossing.isEmpty {
                let crossingCopy = crossing
                for crossingTruck in crossingCopy {
                    // 다리위에 트럭들 이동
                    crossingTruck.move(on: self, secound: 1)
                    if .done == crossingTruck.state {
                        // 다 지나가면 삭제
                        crossing.removeFirst()
                    }
                }
            }
            if let first = queue.first, isAddable(first) {
                // 새 트럭 추가할 수 있으면 추가
                let newTruck = queue.removeFirst()
                addCross(newTruck)
            }
        }
        return timer
    }
    
    func isAddable(_ truck: Truck) -> Bool {
        return crossing.count < maxCount && truck.weight <= acceptableWeight
    }
    
    func addCross(_ truck: Truck) {
        truck.move(on: self, secound: 1)
        crossing.append(truck)
    }
}
