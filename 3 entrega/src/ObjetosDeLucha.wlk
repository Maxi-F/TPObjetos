import FuerzaOscura.*
import Hechizos.*

class PesoYDiasArtefacto {
	var dias
	var peso
	
	constructor(unosDias, unPeso) {
		dias = unosDias
		peso = unPeso
	}
	
	method pesoTotal(portador) = peso - (dias/100).min(1)
}


class Arma inherits PesoYDiasArtefacto{
	var tipoDeArma
	
	constructor(unTipoDeArma, unosDias, unPeso) = super(unosDias, unPeso){
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
	
	method pesoTotal(portador) = self.unidadesDeLucha(portador).max(0)
	
	method noEsEspejo() = true
}

class Armadura{
	var refuerzo
	var valorBaseDeArmadura
	var peso
	
	constructor(unRefuerzo, unValorBaseDeArmadura, unPeso){
		refuerzo = unRefuerzo
		valorBaseDeArmadura = unValorBaseDeArmadura
		peso = unPeso
	}
	
	method cambiarRefuerzo(nuevoRefuerzo) { refuerzo = nuevoRefuerzo }
	
	method unidadesDeLucha(portador) = valorBaseDeArmadura + refuerzo.valorDelRefuerzo(portador)
	
	method precio(portador) = refuerzo.precioDelRefuerzo(portador, valorBaseDeArmadura)
	
	method pesoTotal(portador) = peso + refuerzo.pesoExtra()
	
	method noEsEspejo() = true
} 

class CotaDeMalla{
	var valorDelRefuerzo
	
	constructor(unValorDelRefuerzo){
		valorDelRefuerzo = unValorDelRefuerzo
	}
	
	method valorDelRefuerzo(portador) = valorDelRefuerzo
	
	method pesoExtra() = 1
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorDelRefuerzo/2
	
}

object bendicion{
	method valorDelRefuerzo(portador) = portador.nivelDeHechiceria()
	
	method pesoExtra() = 0
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura
}

object collarDivino{
	var property perlas = 5

	method unidadesDeLucha(portador) = perlas
	
	method precio(portador) = perlas*2
	
	method pesoTotal(portador) = 0.5 * perlas
	
	method noEsEspejo() = true
}

object ningunRefuerzo{
	method valorDelRefuerzo(portador) = 0
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = 2
	
	method pesoExtra() = 0
}

class Espejo inherits PesoYDiasArtefacto {
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



