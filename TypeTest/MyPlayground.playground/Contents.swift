import UIKit
import Foundation

struct Item: Identifiable {
    let id: Int
    let name: String
}

// 配列の作成
let items = [
    Item(id: 1, name: "Item1"),
    Item(id: 2, name: "Item2"),
    Item(id: 3, name: "Item3"),
    Item(id: 4, name: "Item4")
]

// IDを指定して配列からアイテムを検索する関数
func searchItemByID(items: [Item], id: Int) -> Item? {
    return items.first(where: { $0.id == id })
}

// ID検索の実行例
let targetID = 3
if let foundItem = searchItemByID(items: items, id: targetID) {
    print("Item found: \(foundItem.name)")
} else {
    print("Item not found")
}
//上記のコードでは、Itemというモデルクラスを定義し、Identifiableプロトコルに準拠しています。Itemはidとnameという2つのプロパティを持ちます。
//
//次に、itemsという配列を作成し、Itemオブジェクトを格納しています。
//
//searchItemByIDという関数は、配列とIDを受け取り、first(where:)メソッドを使って配列内のアイテムをIDで検索する関数です。検索結果はオプショナルで返されるため、アイテムが見つかった場合はそのアイテムを、見つからなかった場合はnilを返します。
//
//最後に、targetIDを指定してsearchItemByID関数を呼び出し、検索結果を出力しています。もしアイテムが見つかれば、その名前を表示し、見つからなかった場合は「Item not found」と表示されます。







