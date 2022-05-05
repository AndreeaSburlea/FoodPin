//
//  Restaurant.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

 struct Restaurant: Hashable {
     // swiftlint:disable line_length
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

     private var _phone: String = ""
      var phone: String {
          get {
              return _phone
          }
          set {
              _phone = newValue
          }
      }

     private var _description: String = ""
      var description: String {
          get {
              return _description
          }
          set {
              _description = newValue
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

     private var _rating: Rating?
     var rating: Rating? {
         get {
             return _rating
         }
         set {
             _rating = newValue
         }
     }

     enum Rating: String {
         case awesome
         case good
         case okay
         case bad
         case terrible

        var image: String {
            switch self {
            case .awesome: return "love"
            case .good: return "cool"
            case .okay: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
     }

     public init(name: String, type: String, location: String, phone: String, description: String, image: String, isFavorite: Bool) {
        self._name = name
        self._type = type
        self._location = location
        self._phone = phone
        self._description = description
        self._image = image
        self._isFavorite = isFavorite
    }
}
