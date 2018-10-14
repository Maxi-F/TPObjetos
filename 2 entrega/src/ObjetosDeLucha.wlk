import FuerzaOscura.*

class Arma{
	var tipoDeArma
	
	constructor(unTipoDeArma){
		tipoDeArma = unTipoDeArma
	}
	
	method unidadesDeLucha(portador) = 3
}

class MascaraOscura{
	var indiceDeOscuridad
	var valorMinimo
	
	constructor(unIndiceDeOscuridad, unValorMinimo){
		indiceDeOscuridad = unIndiceDeOscuridad
		valorMinimo = unValorMinimo
	}
	
	method unidadesDeLucha(portador) = valorMinimo.max(0.5*fuerzaOscura.valor()*indiceDeOscuridad)
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
} 

class CotaDeMalla{
	var valorDelRefuerzo
	
	constructor(unValorDelRefuerzo){
		valorDelRefuerzo = unValorDelRefuerzo
	}
	
	method valorDelRefuerzo(portador) = valorDelRefuerzo
}

object bendicion{
	method valorDelRefuerzo(portador) = portador.nivelDeHechiceria()
}

object ningunRefuerzo{
	method valorDelRefuerzo(portador) = 0
}

object espejo{
	method unidadesDeLucha(portador){
		if (portador.soloTieneAlEspejo())
			return 0
		else
			return portador.unidadesDeLuchaDePertenenciaMasPoderosa()
	}
}

class LibroDeHechizos{
	var hechizos
	
	constructor(unosHechizos){
		hechizos = unosHechizos
	}
		
	method agregarHechizo(nuevoHechizo) { hechizos.add(nuevoHechizo) }
	
	method poder() = hechizos.filter({unHechizo => unHechizo.esHechizoPoderoso()}).sum({unHechizo => unHechizo.poder()})
}

object collarDivino{
	var property perlas = 5
	
	method unidadesDeLucha(portador) = perlas
	
	
}


