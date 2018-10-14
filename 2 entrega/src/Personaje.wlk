import FuerzaOscura.*
import ObjetosDeLucha.*
import Hechizos.*

class Personaje {
	var hechizoPreferido
	var artefactos
	var property valorBaseDeLucha
	
	constructor(unHechizoPreferido, unosArtefactos, unValorBaseDeLucha) {
		hechizoPreferido = unHechizoPreferido
		artefactos = unosArtefactos
		valorBaseDeLucha = unValorBaseDeLucha
	}
	
	method nivelDeHechiceria() = 3 * hechizoPreferido.poder() + fuerzaOscura.valor()
	
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
	
	method unidadesDeLuchaDePertenenciaMasPoderosa() = self.pertenenciaMasPoderosa().unidadesDeLucha(self)
	
	method estaCargado() = artefactos.size() >= 5
}
