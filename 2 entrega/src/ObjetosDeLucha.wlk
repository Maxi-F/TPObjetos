import FuerzaOscura.*
import Hechizos.*

class Arma{
	var tipoDeArma
	
	constructor(unTipoDeArma){
		tipoDeArma = unTipoDeArma
	}
	
	method unidadesDeLucha(portador) = 3
	
	method noEsEspejo() = true
	
	method precio(portador) = self.unidadesDeLucha(portador)*5
}

class MascaraOscura{
	var indiceDeOscuridad
	var valorMinimo
	
	constructor(unIndiceDeOscuridad, unValorMinimo){
		indiceDeOscuridad = unIndiceDeOscuridad
		valorMinimo = unValorMinimo
	}
	
	method unidadesDeLucha(portador) = valorMinimo.max(0.5*fuerzaOscura.valor()*indiceDeOscuridad)
	
	method noEsEspejo() = true
}

class Armadura{
	var refuerzo
	var valorBaseDeArmadura
	
	constructor(unRefuerzo, unValorBaseDeArmadura){
		refuerzo = unRefuerzo
		valorBaseDeArmadura = unValorBaseDeArmadura
	}
	
	method cambiarRefuerzo(nuevoRefuerzo) { refuerzo = nuevoRefuerzo }
	
	method unidadesDeLucha(portador) = valorBaseDeArmadura + refuerzo.valorDelRefuerzo(portador)
	
	method precio(portador) = refuerzo.precioDelRefuerzo(portador, valorBaseDeArmadura)
	
	method noEsEspejo() = true
} 

class CotaDeMalla{
	var valorDelRefuerzo
	
	constructor(unValorDelRefuerzo){
		valorDelRefuerzo = unValorDelRefuerzo
	}
	
	method valorDelRefuerzo(portador) = valorDelRefuerzo
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorDelRefuerzo/2
	
}

object bendicion{
	method valorDelRefuerzo(portador) = portador.nivelDeHechiceria()
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura
}

object collarDivino{
	var property perlas = 5
	
	method unidadesDeLucha(portador) = perlas
	
	method precio(portador) = perlas*2
	
	method noEsEspejo() = true
}

object ningunRefuerzo{
	method valorDelRefuerzo(portador) = 0
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = 2
}

object espejo{
	method unidadesDeLucha(portador){
		if (portador.soloTieneAlEspejo())
			return 0
		else
			return portador.unidadesDeLuchaDePertenenciaMasPoderosa()
	}
	
	method precio(portador) = 90
	
	method noEsEspejo() = false
}

class LibroDeHechizos{
	var hechizos
	
	constructor(unosHechizos){
		hechizos = unosHechizos
	}
		
	method agregarHechizo(nuevoHechizo) { hechizos.add(nuevoHechizo) }
	
	method poder() = hechizos.filter({unHechizo => unHechizo.esHechizoPoderoso()}).sum({unHechizo => unHechizo.poder()})
	
	method precio(portador) = hechizos.size()*10 + self.poder()
	
	method noEsEspejo() = true
}



