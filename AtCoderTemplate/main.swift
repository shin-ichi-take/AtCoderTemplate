//
//  main.swift
//  AtCoderTemplate
//
//  Created by 竹村信一 on 2024/11/30.
//

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


@inlinable func read2IntsTupple() -> (Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1])
}

@inlinable func read3IntsTupple() -> (Int,Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1],tmp[2])
}

@inlinable func read4IntsTupple() -> (Int,Int,Int,Int){
    let tmp = readInts()
    return (tmp[0],tmp[1],tmp[2],tmp[3])
}

@inlinable func read5IntsTupple() -> (Int,Int,Int,Int,Int){
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


