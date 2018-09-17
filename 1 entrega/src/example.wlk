/*       _______________________________________________________________________
	|:..                         TP  OBJETOS                   ``:::%%%%%%%%|
	|%%%:::::..            Rol de Lucha y Hechiceria              `:::::%%%%|
	|%%%%%%%:::::.....________________________________________________::::::|
	
	PD: No viniste pedro, no tenes ascii, jodete xd
	
*/

/*----- Punto 1: Hechiceria -----*/

object fuerzaOscura {
	var poder = 5
	
	method eclipse() { poder *= 2 }
	
	method valor() = poder
}

object rolando {
	var hechizoPreferido
	var artefactos = []
	var property valorBaseDeLucha = 1
	
	method nivelDeHechiceria() = 3*hechizoPreferido.poder() + fuerzaOscura.valor()
	
	method cambiarHechizoPreferido(nuevoHechizo) { hechizoPreferido = nuevoHechizo }
	
	method esPoderoso() = hechizoPreferido.esHechizoPoderoso()
	
	method agregarArtefacto(nuevoArtefacto) { artefactos.add(nuevoArtefacto) }
	
	method removerArtefacto(artefacto) { artefactos.remove(artefacto) }
	
	method removerTodosLosArtefactos() { artefactos.clear() }
	
	method aporteDeArtefactos() = artefactos.sum({unArtefacto => unArtefacto.unidadesDeLucha(self)})
	
	method habilidadParaLaLucha() = valorBaseDeLucha + self.aporteDeArtefactos()
	
	method habilidadEsMayorQueHechiceria() = self.habilidadParaLaLucha() > self.nivelDeHechiceria()
	
	method soloTieneAlEspejo() = artefactos == [espejo]
	
	method pertenenciaMasPoderosa() = artefactos.max({unArtefacto => if(unArtefacto != espejo) unArtefacto.unidadesDeLucha(self) else 0})
	
	method estaCargado() = artefactos.size() >= 5
}

object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method cambiarNombre(nuevoNombre) { 
		nombre = nuevoNombre
	}
	
	method poder() = nombre.size()
	
	method esHechizoPoderoso() = self.poder() > 15
	
	method valorDelRefuerzo(portador) = self.poder()
}

object hechizoBasico {
	method poder() = 10
	
	method esHechizoPoderoso() = false
	
	method valorDelRefuerzo(portador) = self.poder()
}

/*----- Punto 2: Lucha -----*/

object espadaDelDestino{
	method unidadesDeLucha(portador) = 3
}

object collarDivino{
	var property perlas = 5
	
	method unidadesDeLucha(portador) = perlas
}

object mascaraOscura{
	method unidadesDeLucha(portador) = 4.max(0.5*fuerzaOscura.valor())
}

/*----- Punto 3: Lucha y hechiceria avanzada -----*/

object armadura{
	var refuerzo = ningunRefuerzo
	
	method cambiarRefuerzo(nuevoRefuerzo) { refuerzo = nuevoRefuerzo }
	
	method unidadesDeLucha(portador) = 2 + refuerzo.valorDelRefuerzo(portador)
} 

object cotaDeMalla{
	method valorDelRefuerzo(portador) = 1
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
			return portador.pertenenciaMasPoderosa().unidadesDeLucha(portador)
	}
}

object libroDeHechizos{
	var hechizos = []
		
	method agregarHechizo(nuevoHechizo) { hechizos.add(nuevoHechizo) }
	
	method poder() = hechizos.sum({unHechizo => if(unHechizo.esHechizoPoderoso()) unHechizo.poder() else 0})
}

/*

¿Que sucede si el libro de hechizos incluye como hechizo al mismo libro de hechizos?
* Dara un mensaje de error indicando que el object "libroDeHechizos" no entiende el mensaje "unidadesDeLucha()"

wollok.lang.MessageNotUnderstoodException: libroDeHechizos[hechizos=[libroDeHechizos]] no entiende el mensaje unidadesDeLucha()

*/

