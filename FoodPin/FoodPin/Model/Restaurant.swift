//
//  Restaurant.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

 struct Restaurant: Hashable {
    private var _name: String = ""
     var name: String {
         get {
             return _name
         }
         set {
             _name = newValue
         }
     }

    private var _type: String = ""
     var type: String {
         get {
             return _type
         }
         set {
             _type = newValue
         }
     }

    private var _location: String = ""
     var location: String {
         get {
             return _location
         }
         set {
             _location = newValue
         }
     }

    private var _image: String = ""
     var image: String {
         get {
             return _image
         }
         set {
             _image = newValue
         }
     }

    private var _isFavorite: Bool = false
     var isFavorite: Bool {
         get {
             return _isFavorite
         }
         set {
             _isFavorite = newValue
         }
     }

    public init(name: String, type: String, location: String, image: String, isFavorite: Bool) {
        self._name = name
        self._type = type
        self._location = location
        self._image = image
        self._isFavorite = isFavorite
    }
}
