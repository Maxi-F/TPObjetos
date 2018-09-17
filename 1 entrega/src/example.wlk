/*       _______________________________________________________________________
	|:..                         TP  OBJETOS                   ``:::%%%%%%%%|
	|%%%:::::..            Rol de Lucha y Hechiceria              `:::::%%%%|
	|%%%%%%%:::::.....________________________________________________::::::|
*/

/*----- Punto 1: Hechiceria -----*/

object fuerzaOscura {
	var poder = 5
	
	method eclipse() { poder *= 2 }
	
	method valor() = poder
}

object rolando {
	var hechizoPreferido = espectroMalefico
	var artefactos = []
	var property valorBaseDeLucha = 1
	
	method nivelDeHechiceria() = 3*hechizoPreferido.poder() + fuerzaOscura.valor()
	
	method cambiarHechizoPreferido(nuevoHechizo) { hechizoPreferido = nuevoHechizo }
	
	method esPoderoso() = hechizoPreferido.esHechizoPoderoso()
	
	method agregarArtefacto(nuevoArtefacto) { artefactos.add(nuevoArtefacto) }
	
	method removerArtefacto(artefacto) { artefactos.remove(artefacto) }
	
	method removerTodosLosArtefactos() { artefactos.clear() }
	
	method aporteDeArtefactos() = artefactos.sum({unArtefacto => unArtefacto.unidadesDeLucha()})
	
	method habilidadParaLaLucha() = valorBaseDeLucha + self.aporteDeArtefactos()
	
	method habilidadEsMayorQueHechiceria() = self.habilidadParaLaLucha() > self.nivelDeHechiceria()
	
	method soloTieneAlEspejo() = artefactos == [espejo]
	
	method pertenenciaMasPoderosa() = artefactos.max({unArtefacto => if(unArtefacto != espejo) unArtefacto.unidadesDeLucha() else -1})
	
	method estaCargado() = artefactos.size() >= 5
}

object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method cambiarNombre(nuevoNombre) { nombre = nuevoNombre }
	
	method poder() = nombre.size()
	
	method esHechizoPoderoso() = self.poder() > 15
	
	method valorDelRefuerzo() = self.poder()
}

object hechizoBasico {
	method cambiarNombre(nuevoNombre) {}
	
	method poder() = 10
	
	method esHechizoPoderoso() = false
	
	method valorDelRefuerzo() = self.poder()
}

/*----- Punto 2: Lucha -----*/

object espadaDelDestino{
	method unidadesDeLucha() = 3
}

object collarDivino{
	var property perlas = 5
	
	method unidadesDeLucha() = perlas
}

object mascaraOscura{
	method unidadesDeLucha() = 4.max(0.5*fuerzaOscura.valor())
}

/*----- Punto 3: Lucha y hechiceria avanzada -----*/

object armadura{
	var refuerzo = ningunRefuerzo
	
	method cambiarRefuerzo(nuevoRefuerzo) { refuerzo = nuevoRefuerzo }
	
	method unidadesDeLucha() = 2 + refuerzo.valorDelRefuerzo()
} 

object cotaDeMalla{
	method valorDelRefuerzo() = 1
}

object bendicion{
	method valorDelRefuerzo() = rolando.nivelDeHechiceria()
}

object ningunRefuerzo{
	method valorDelRefuerzo() = 0
}

object espejo{
	method unidadesDeLucha(){
		if (rolando.soloTieneAlEspejo())
			return 0
		else
			return rolando.pertenenciaMasPoderosa().unidadesDeLucha()
	}
}

object libroDeHechizos{
	var hechizos = []
	
	method cambiarNombre(nuevoNombre) {}
		
	method agregarHechizo(nuevoHechizo) { if(nuevoHechizo != self) hechizos.add(nuevoHechizo) else self.error("Accion invalida. Pruebe otro hechizo.") }
	
	method poder() = hechizos.sum({unHechizo => if(unHechizo.esHechizoPoderoso()) unHechizo.poder() else 0})
	
	method esHechizoPoderoso(){}
}

/*

¿Que sucede si el libro de hechizos incluye como hechizo al mismo libro de hechizos?
* Dara un mensaje de error indicando que el object "libroDeHechizos" no entiende el mensaje "unidadesDeLucha()"

wollok.lang.MessageNotUnderstoodException: libroDeHechizos[hechizos=[libroDeHechizos]] no entiende el mensaje unidadesDeLucha()

* En este caso, al añadir una excepcion propia, indicara que agregar libroDeHechizos como hechizo al libroDeHechizo es una accion invalida

*/
