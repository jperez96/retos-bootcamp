//: [Previous](@previous)

import Foundation

func getImc( weighKg : Double , heightM : Double) -> Double{
    return weighKg / pow(heightM, 2)
}

func getStatusFromImc(_ imc : Double) {
    switch imc {
    case imc where imc <= 15:
        print("Delgadez muy severa")
    case imc where imc <= 15.9:
        print("Delgadez severa")
    case imc where imc < 18.4:
        print("Delgadez")
    case imc where imc < 24.9:
        print("Peso Saludable")
    case imc where imc < 29.9:
        print("Sobrepeso")
    case imc where imc < 34.9:
        print("Obesidad Moderada")
    case imc where imc < 39.9:
        print("Obesidad severa")
    default:
        print("Obesidad muy severa (obesidad mórbida)")
    }
}

let imc = getImc(weighKg: 100, heightM: 1.76)
getStatusFromImc(imc)
		
	 
