import UIKit
import Foundation

struct Animal {
    let id = UUID()
    var name: String
    var food: [Food]
}
struct Food {
    let id = UUID()
    let foodName: String
}
var animals = [
    Animal(name: "さる", food: [Food(foodName: "バナナ"),Food(foodName: "もも"),Food(foodName: "りんご")]),
    Animal(name: "ライオン", food: [Food(foodName: "牛肉"),Food(foodName: "豚肉"),Food(foodName: "鶏肉")]),
    Animal(name: "人間", food: [Food(foodName: "トマト"),Food(foodName: "卵"),Food(foodName: "コメ")]),
]
func animalFoodRemove(animal: Animal, foodA: Food){
   guard let index = animals.firstIndex(where: {
       $0.name == animal.name
   }) else { return }
   guard let foodIndex = animals[index].food.firstIndex(where: {
       $0.foodName == foodA.foodName
   }) else { return }
    animals[index].food.remove(at: foodIndex)
}
animalFoodRemove(animal: Animal(name: "人間", food: []), foodA: Food(foodName: "トマト"))
print(animals)

