import Foundation

//RETO SWIFT
//Teniendo ciertos datos de 6 personas, se crea una lista de personas que contenga datos como nombre, apellido paterno, apellido materno, fecha de nacimiento, nro de documento, sexo, correo, la cantidad de hermanos y usuario de cada persona.
//
//NOTA
//
//No te vendrá el usuario de por sí, por lo que ese campo será nulo al inicio. Tendrás que obtenerlo a partir del correo. Si mi correo es luis.ingam@gmail.com, entonces mi usuario es  luis.ingam
//
//Lo obtengo con todo lo que hay antes de la arroba @
//
//Datos de entrada:
//
//CARLOS JOSÉ ROBLES GOMES, fecha de nacimiento: 06/08/1995, numero de documento 78451245, tiene 2 hermanos, carlos.roblesg@hotmail.com
//MIGUEL ANGEL QUISPE OTERO, fecha de nacimiento: 28/12/1995, numero de documento 79451654, no tiene hermanos, miguel.anguel@gmail.com
//KARLA ALEXANDRA FLORES ROSAS, fecha de nacimiento: 15/02/1997, numero de documento 77485812, tiene 1 hermanos, Karla.alexandra@hotmail.com
//NICOLAS QUISPE ZEBALLOS, fecha de nacimiento: 08/10/1990, numero de documento 71748552, tiene 1 hermanos, nicolas123@gmail.com
//PEDRO ANDRE PICASSO BETANCUR, fecha de nacimiento: 17/05/1994, numero de documento 74823157, tiene 2 hermanos, pedroandrepicasso@gmail.com
//FABIOLA MARIA PALACIO VEGA, fecha de nacimiento: 02/02/1992, numero de documento 76758254, no tiene hermanos, fabi@hotmail.com](mailto:fabi@hotmail.com

//A partir de esta lista:
//
//- Obtener la persona con mayor y menor edad
//- Obtener dos listas más, una para hombres y otra mara mujeres e imprimir la cantidad de personas que hay en cada lista
//- Obtener una lista de todas las personas que tienen más de dos hermanos
//- Imprimir cada persona con este formato “Luis Inga M.” Solo primer nombre, ape pate completo y solo la inicial del ape mate más un punto. Y EN CAPITALIZE (primera letra de cada palabra en mayúscula y todo lo demás en minúscula)
//- Crear usuarios a todas las personas y guardar en la lista.

// Models

enum Gender {
    case MALE, FEMALE, OTHER
}
                                                                                                                                
class Person {
    var firstName : String
    var lastnameF : String
    var lastnameM : String
    var birthday : Date
    var identifier: String
    var gender : Gender
    var email : String
    var siblings: Int
    var user: String
    
    
    init(name: String, lastnameF: String, lastnameM: String , birthdayString: String, identifier: String, gender: Gender, email: String, siblings: Int) {
        self.firstName = name
        self.lastnameF = lastnameF
        self.lastnameM = lastnameM
        self.birthday = birthdayString.toDate()
        self.identifier = identifier
        self.gender = gender
        self.email = email
        self.siblings = siblings
        self.user = ""
    }
    
    func printName() -> String {
        return "\(self.firstName.capitalized) \(self.lastnameF.capitalized) \(self.lastnameM.capitalized.first!)."
    }

    func printNameAndUser() -> String {
        return "Nombre: \(self.firstName.capitalized) \(self.lastnameF.capitalized) \(self.lastnameM.capitalized.first!). - Usuario: \(self.user)"
    }

}



enum ErrorMessage : String{
    case UserError = "Error al generar el usuario"
    case StringError = "No se pudo obtener el String"
}

// Functions

func getDateFromStringDate(dateString : String) -> Date {
    let dateString = dateString.trimmingCharacters(in: .whitespaces)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.date(from: dateString)!
}

func calcAge(birthday: String) -> Int {
    let seconds = (Int(birthday)!/1000) as NSNumber?
    let timeStampDate = Date(timeIntervalSince1970: seconds!.doubleValue)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    let calcAge = calendar.components(.year, from: timeStampDate, to: now, options: [])
    let age = calcAge.year
    return age!
  }

func generateUserByEmail(email: String) -> String{
    let list = email.components(separatedBy: "@")
    if let user = list.first {
        return user
    } else {
        return ErrorMessage.UserError.rawValue
    }
}

func getOldestFromPeople(people: [Person]) -> Person? {
    return people.max { a, b in
        a.birthday.getAge() < b.birthday.getAge()
    }
}

func getYoungestFromPeople(people: [Person]) -> Person? {
    return people.max { a, b in
        a.birthday.getAge() > b.birthday.getAge()
    }
}

func getPeopleByGender(people: [Person] , gender: Gender) -> [Person]{
    return people.filter { person in
        person.gender == gender
    }
}

func getPeopleByAmountOfSiblings(people: [Person], amount : Int) -> [Person]{
    return people.filter { person in
        person.siblings >= amount
    }
}

// Extensions

extension String {
    func toDate() -> Date{
        return getDateFromStringDate(dateString: self)
    }
    
    func getFirtsCharacterFromName() -> String{
        let character = self.first!
        return "\(character)."
    }
    
}

extension Date {
    func getAge() -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: self)
        let end = calendar.startOfDay(for: Date())
        return calendar.dateComponents([.year], from: start, to: end).year!
    }
}

func generateData() -> [Person] {
    var people : [Person] = []
    people.append(Person(name: "CARLOS JOSÉ", lastnameF: "ROBLES", lastnameM: "GOMES", birthdayString: "06/08/1995", identifier: "78451245", gender: Gender.MALE, email: "carlos.roblesg@hotmail.com", siblings: 2))
    people.append(Person(name: "MIGUEL ANGEL", lastnameF: "QUISPE", lastnameM: "OTERO", birthdayString: "28/12/1995", identifier: "79451654", gender: Gender.MALE, email: "miguel.anguel@gmail.com", siblings: 0))
    people.append(Person(name: "KARLA ALEXANDRA", lastnameF: "FLORES", lastnameM: "ROSAS", birthdayString: "15/02/1997", identifier: "77485812", gender: Gender.FEMALE, email: "karla.alexandra@hotmail.com", siblings: 1))
    people.append(Person(name: "NICOLAS", lastnameF: "QUISPE", lastnameM: "ZEBALLOS", birthdayString: "08/10/1990", identifier: "71748552", gender: Gender.MALE, email: "nicolas123@gmail.com", siblings: 1))
    people.append(Person(name: "PEDRO ANDRE", lastnameF: "PICASSO", lastnameM: "BETANCUR", birthdayString: "17/05/1994", identifier: "74823157", gender: Gender.MALE, email: "pedroandrepicasso@gmail.com", siblings: 2))
    people.append(Person(name: "FABIOLA MARIA", lastnameF: "PALACIO", lastnameM: "VEGA", birthdayString: "02/02/1992", identifier: "76758254", gender: Gender.FEMALE, email: "fabi@hotmail.com](mailto:fabi@hotmail.com", siblings: 0))
    return people
}

let people = generateData()

print("Persona con  mas edad.")
print(getOldestFromPeople(people: people)!.printName())

print("Persona con  menos edad.")
print(getYoungestFromPeople(people: people)!.printName())

print("Persona con  mas o 2 hermanos.")
for person in getPeopleByAmountOfSiblings(people: people, amount: 2) {
    print(person.printName())

}

print("Registrando usuarios.")
for person in people {
    person.user = generateUserByEmail(email: person.email)
    print(person.printNameAndUser())
}
