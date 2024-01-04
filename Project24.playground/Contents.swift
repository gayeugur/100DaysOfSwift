import UIKit

let name = "Taylor"

let letter = name[name.index(name.startIndex, offsetBy: 3)]

let password = "12345"
password.hasPrefix("123") // hasPrefix: dizenin bu sekilde baslayıp baslamadığı
password.hasSuffix("345") // hasSuffix: dizenin bu sekilde bitip bitmediği

let weather = "it's going to rain"
print(weather.capitalized) //metni baş harfleri büyük olacak şekilde yazdırır.

let input = "Swift is like Objective-C without the C"
input.contains("Swift") //input'un "Swift" kelimesini içerip içermediğini kontrol eder.

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift") //languages dizisinin "Swift" kelimesini içerip içermediğini kontrol eder.

input.containsAny(of: languages) // input'un languages dizisindeki herhangi bir kelimeyi içerip içermediğini kontrol eder.

languages.contains(where: input.contains) //languages dizisinde, input metninde herhangi bir kelimenin bulunup bulunmadığını kontrol eder.

extension String {
    // Belirli bir indeksteki karakteri döndürür.
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    //Belirtilen önekten metni kaldırır.
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    // Belirtilen sonekten metni kaldırır.
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    // Metnin ilk harfini büyük harfe dönüştürür.
    var capitalizedFirst: String {
          guard let firstLetter = self.first else { return "" }
          return firstLetter.uppercased() + self.dropFirst()
      }
    
    //  Belirtilen dizide herhangi bir öğenin metinde bulunup bulunmadığını kontrol eder.
    func containsAny(of array: [String]) -> Bool {
           for item in array {
               if self.contains(item) {
                   return true
               }
           }
           return false
       }
}



let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

