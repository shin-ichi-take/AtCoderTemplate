//
//  main.swift
//  AtCoderTemplate
//
//  Created by 竹村信一 on 2024/11/30.
//

// ⭐️AtCoder データ読み込みポイント⭐️
//１つの整数を読み込む場合
//readInt()
//
//スペースで区切られた整数列を１行読み込む場合
//readInts()
//
//文字列を読み込む場合
//readString()
//
//スペースで区切られた文字列を１行読み込む場合
//readStrings()

//文字列を[String]にしたい場合
//例："abc" -> ["a","b","c"]
//readString().map{String($0)}
//
//[String]を文字列にしたい場合
//例：["a","b","c"] -> "abc"
//let arr = ["a","b","c"]
//let str = arr.joined()
//
//[String]の要素ごとにスペースで区切った文字列が欲しい場合
//例：["a","b","c"] -> "a b c"
//let arr = ["a","b","c"]
//let str = arr.joined(separator: " ")

//次のようなデータを２次元配列で読み込みたい場合
//10 20 30
//40 50 60
//70 80 90
//
//var arr = [[Int]]()
//for _ in 0 ..< 3{
//    arr.append(readInts())
//}

//⭐️幅優先探索にはDequeを用いる
//加えるにはappend()
//取り出すにはpopFirst()
//を用いる


import Collections
import Foundation

// 整数読み込み
@inlinable func readInt() -> Int{
    return Int(readLine()!)!
}

// 整数列を読み込み
@inlinable func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map { Int(String($0))! }
}

// 文字列読み込み
@inlinable func readString() -> String{
    return readLine()!
}

func readStrings() -> [String] {
    return readLine()!.split(separator: " ").map { String($0) }
}


@inlinable func read2IntsTuple() -> (Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1])
}

@inlinable func read3IntsTuple() -> (Int,Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1],tmp[2])
}

@inlinable func read4IntsTuple() -> (Int,Int,Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1],tmp[2],tmp[3])
}

@inlinable func read5IntsTuple() -> (Int,Int,Int,Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1],tmp[2],tmp[3],tmp[4])
}


/// 二分探索アルゴリズム
/// a[index] >= keyという条件を満たす最小のindexを返す
func lowerBound(key:Int,arr:[Int]) -> Int{
    func isOK(index:Int,key:Int) -> Bool{
        return arr[index] >= key
    }
    var left = -1
    var right = arr.count
    
    while right - left > 1{
        let mid = (left+right)/2
        if isOK(index: mid, key: key){
            right = mid
        }else{
            left = mid
        }
    }
    return right
}


/*
let a = [1, 14, 32, 51, 51, 51, 243, 419, 750, 910]

print(lowerBound(key: 51, arr: a))
print(lowerBound(key: 1, arr: a))
print(lowerBound(key: 910, arr: a))
print(lowerBound(key: 52, arr: a))

print(">=")
let b = [1, 14, 32, 51, 51, 51, 243, 419, 750, 910].sorted(by: >)
print(lowerBound(key: 51, arr: b, compare: >=))
print(lowerBound(key: 1, arr: b, compare: >=))
print(lowerBound(key: 910, arr: b, compare : >=))
print(lowerBound(key: 52, arr: b, compare: >=))
print(lowerBound(key: 50, arr: b, compare: >=))
// 二分探索アルゴリズム
// 昇順の場合 key以上となる最小のインデックス値
// 降順の場合 key以下となる最小インデックス値
*/
func lowerBound(key:Int,arr:[Int],compare:(Int,Int) -> Bool) -> Int{
    var left = -1
    var right = arr.count
    while right - left > 1{
        let mid = (left+right)/2
        if compare(key,arr[mid]){
            right = mid
        }else{
            left = mid
        }
    }
    return right
}


/// 内部でArraySliceを使っている
public struct Array2Dim<T:Equatable>{
    private var _value: ArraySlice<ArraySlice<T>>
    public init(_ M:Int,_ N:Int,repeating:T){
        _value = ArraySlice<ArraySlice<T>>(repeating: ArraySlice(repeating: repeating, count: N), count: M)
    }
    public init(){
        _value = ArraySlice<ArraySlice<T>>()
    }
    public subscript(i:Int) -> ArraySlice<T>{
        get{
            _value[i]
        }
        set{
            _value[i] = newValue
        }
    }
}

public struct Array1Dim<T:Equatable>{
    private var _value: ArraySlice<T>
    public init(){
        _value = []
    }
    public init(_ N:Int,repeating:T){
        _value = ArraySlice(repeating: repeating, count: N)
    }
    public subscript(i:Int) -> T{
        get{
            _value[i]
        }
        set{
            _value[i] = newValue
        }
    }
}

/// キュー構造
/// 主に幅優先探索で用いる
public struct Queue<T> {
    fileprivate var array = ArraySlice<T>()
    
    //数を返す
    public var count: Int {
        return array.count
    }
    
    //アペンドで末尾に入れる（更新させるからmutating)
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    //空であればnil,先頭から取り除く　（更新させるからmutating)
    public mutating func dequeue() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    //先頭の要素を返す
    public var front: T? {
        return array.first
    }
    public var end:T? {
        return array.last
    }
}

// 優先度付きキュー
// ソース元https://qiita.com/conf8o/items/a89ce80d5b7a51550a33
struct PriorityQueue<T> {
    private var data: [T]
    private var ordered: (T, T) -> Bool
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    public var count: Int {
        return data.count
    }

    init(_ order: @escaping (T, T) -> Bool) {
        self.data = []
        self.ordered = order
    }

    init<Seq: Sequence>(_ seq: Seq, _ order: @escaping (T, T) -> Bool) where Seq.Element == T {
        self.data = []
        self.ordered = order
        
        for x in seq {
            push(x)
        }
    }
    
    public mutating func pop() -> T? {
        return data.popLast().map { item in
            var item = item
            if !isEmpty {
                swap(&item, &data[0])
                siftDown()
            }
            return item
        }
    }
    
    public mutating func push(_ item: T) {
        let oldLen = count
        data.append(item)
        siftUp(oldLen)
    }
    
    private mutating func siftDown() {
        var pos = 0
        let end = count
        
        data.withUnsafeMutableBufferPointer { bufferPointer in
            let _data = bufferPointer.baseAddress!
            swap(&_data[0], &_data[end])
            
            var child = 2 * pos + 1
            while child < end {
                let right = child + 1
                if right < end && ordered(_data[right], _data[child]) {
                    child = right
                }
                swap(&_data[pos], &_data[child])
                pos = child
                child = 2 * pos + 1
            }
        }
        siftUp(pos)
    }
    
    private mutating func siftUp(_ pos: Int) {
        var pos = pos
        while pos > 0 {
            let parent = (pos - 1) / 2;
            if ordered(data[parent], data[pos]) {
                break
            }
            data.swapAt(pos, parent)
            pos = parent
        }
    }
}

extension PriorityQueue: Sequence, IteratorProtocol {
    mutating func next() -> T? {
        return pop()
    }
}




// 範囲を生成
@inlinable func range(_ start:Int,_ end:Int) -> Range<Int>{
    return start ..< end
}

@inlinable func range(_ end:Int) -> Range<Int>{
    return 0 ..< end
}

@inlinable func rangeStride(_ start:Int,_ end:Int,_ step:Int) -> StrideTo<Int>{
    return stride(from: start, to: end, by: step)
}

// 繰り返し二乗法
func repSq(_ a:Int,n:Int) -> Int{
    var N = n
    var base = a
    var ans = 1
    while N > 0{
        if N & 1 == 1{
            ans *= base
        }
        base *= base
        N >>= 1
    }
    return ans
}

func repSqMod(_ a:Int,n:Int,mod:Int) -> Int{
    var N = n
    var base = a
    var ans = 1
    while N > 0{
        if N & 1 == 1{
            ans *= base
            ans %= mod
        }
        base *= base
        N >>= 1
    }
    return ans
}

//print(repSq(2, n: 3))
//print(repSqMod(3, n: 10, mod: 7))



/// 配列を辞書順で次の順列に変更します。
/// 配列が辞書順で最後の順列（降順）の場合、最初の順列（昇順）に変更されます。
///
/// - Parameter arr: 変更対象の配列（Int型）
func nextPermutation(_ arr: inout [Int]) {
    let n = arr.count
    guard n > 1 else { return }

    // 1. 右から探索し、arr[i] < arr[i + 1] となる最初のインデックス i を見つける
    var i = n - 2
    while i >= 0 && arr[i] >= arr[i + 1] {
        i -= 1
    }

    if i >= 0 {
        // 2. i が見つかった場合、再度右から探索し、arr[i] < arr[j] となる最初のインデックス j を見つける
        var j = n - 1
        while arr[i] >= arr[j] {
            j -= 1
        }
        // 3. arr[i] と arr[j] を交換する
        arr.swapAt(i, j)
    }

    // 4. i + 1 から末尾までを反転させる
    // (i が見つからなかった場合は、配列全体が反転し最初の順列に戻る)
    arr[(i + 1)...].reverse()
}

/*
// MARK: - 実行例

var arr = [1, 2, 3]
print("--- [1, 2, 3] の全順列 ---")
print(arr) // 初期状態

// 3! = 6 なので、6回呼び出すと全ての順列を巡回して元の状態に戻る
for _ in 1...6 {
    nextPermutation(&arr)
    print(arr)
}

print("\n--- [0, 1, 2, 3] の全順列 ---")
var arr2 = [0, 1, 2, 3]
let factorial = (1...arr2.count).reduce(1, *) // 4! = 24
print(arr2)
for _ in 1..<factorial { // 23回呼び出して残りの全順列を表示
    nextPermutation(&arr2)
    print(arr2)
}
*/
