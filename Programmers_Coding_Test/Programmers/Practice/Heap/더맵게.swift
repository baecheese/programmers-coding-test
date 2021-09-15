//
//  더맵게.swift
//  Programmers
//
//  Created by 배지영 on 2021/09/10.
//

import Foundation
/*
 문제 설명
 매운 것을 좋아하는 Leo는 모든 음식의 스코빌 지수를 K 이상으로 만들고 싶습니다.
 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해
 Leo는 스코빌 지수가 가장 낮은 두 개의 음식을 아래와 같이 특별한 방법으로 섞어 새로운 음식을 만듭니다.

 ```
 섞은 음식의 스코빌 지수 = 가장 맵지 않은 음식의 스코빌 지수 + (두 번째로 맵지 않은 음식의 스코빌 지수 * 2)
 ```
 
 Leo는 모든 음식의 스코빌 지수가 K 이상이 될 때까지 반복하여 섞습니다.
 Leo가 가진 음식의 스코빌 지수를 담은 배열 scoville과 원하는 스코빌 지수 K가 주어질 때,
 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해 섞어야 하는 최소 횟수를 return 하도록 solution 함수를 작성해주세요.

 제한 사항
 scoville의 길이는 2 이상 1,000,000 이하입니다.
 K는 0 이상 1,000,000,000 이하입니다.
 scoville의 원소는 각각 0 이상 1,000,000 이하입니다.
 모든 음식의 스코빌 지수를 K 이상으로 만들 수 없는 경우에는 -1을 return 합니다.
 
 입출력 예
       scoville          K        return
 [1, 2, 3, 9, 10, 12]    7          2
 
 입출력 예 설명
 스코빌 지수가 1인 음식과 2인 음식을 섞으면 음식의 스코빌 지수가 아래와 같이 됩니다.
 새로운 음식의 스코빌 지수 = 1 + (2 * 2) = 5
 가진 음식의 스코빌 지수 = [5, 3, 9, 10, 12]

 스코빌 지수가 3인 음식과 5인 음식을 섞으면 음식의 스코빌 지수가 아래와 같이 됩니다.
 새로운 음식의 스코빌 지수 = 3 + (5 * 2) = 13
 가진 음식의 스코빌 지수 = [13, 9, 10, 12]

 모든 음식의 스코빌 지수가 7 이상이 되었고 이때 섞은 횟수는 2회입니다.
 */

func getMixCountToMakeSpicy(scoville: [Int], K: Int) -> Int {
    return Leo(K).mixCount(foods: scoville.map { return Food($0) })
}

class Food {
    
    //Scoville heat units, 스코빌지수(고추의 매운 정도를 나타내는 지수)
    var SHU_value: Int
    
    init(_ shu: Int) {
        self.SHU_value = shu
    }
    
    //섞은 음식의 스코빌 지수 = 가장 맵지 않은 음식의 스코빌 지수 + (두 번째로 맵지 않은 음식의 스코빌 지수 * 2)
    func mix(_ other: Food) -> Food {
        let minFood = min(self, other)
        let nextMinFood = max(self, other)
        return Food(minFood.SHU_value + (nextMinFood.SHU_value * 2))
    }
    
}

extension Food: Comparable, Equatable {
    
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.SHU_value == rhs.SHU_value
    }
    
    static func < (lhs: Food, rhs: Food) -> Bool {
        return lhs.SHU_value < rhs.SHU_value
    }
    
}


class Leo {
    
    private var minScovilleValue: Int
    
    init(_ min: Int) {
        self.minScovilleValue = min
    }
    
    func mixCount(foods: [Food]) -> Int {
        guard 2 < foods.count else { return 0 }
        var count: Int = 0
        var sortedFoods: [Food] = sorted(foods: foods)
        while false == sortedFoods.filter({ $0.SHU_value < minScovilleValue }).isEmpty {
            //섞은 음식의 스코빌 지수 = 가장 맵지 않은 음식의 스코빌 지수 + (두 번째로 맵지 않은 음식의 스코빌 지수 * 2)
            let minFood = sortedFoods.removeFirst()
            let nextMinFood = sortedFoods.removeFirst()
            let mixFood = minFood.mix(nextMinFood)
            sortedFoods.insert(mixFood, at: 0)
            count += 1
        }
        return 0 == count ? -1 : count
    }
    
    private func sorted(foods: [Food]) -> [Food] {
        return foods.sorted { return $0.SHU_value < $1.SHU_value }
    }
    
}
