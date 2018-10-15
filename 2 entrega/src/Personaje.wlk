import FuerzaOscura.*
import ObjetosDeLucha.*
import Hechizos.*
import Excepciones.*

class Personaje {
	var hechizoPreferido
	var artefactos
	var property valorBaseDeLucha
	var oro
	
	constructor(unHechizoPreferido, unosArtefactos, unValorBaseDeLucha, unasMonedasDeOro) {
		hechizoPreferido = unHechizoPreferido
		artefactos = unosArtefactos
		valorBaseDeLucha = unValorBaseDeLucha
		oro = unasMonedasDeOro
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
	
	method cantidadDeArtefactos() = artefactos.size()
	
	method estaCargado() = self.cantidadDeArtefactos() >= 5
	
	method oro() = oro
	
	method comprarHechizo(hechizo){
		self.pagar(hechizo.precio(self) - hechizoPreferido.precio(self)/2)
		hechizoPreferido = hechizo
	}
	
	method pagar(monto){
		if (self.esPagable(monto)){
			oro -= 0.max(monto)
		}
		else
			throw new ExcepcionPorPobreza( "El oro disponible no es suficiente" )
	}
	
	method esPagable(monto) = monto <= oro
	
	method comprarArtefacto(artefacto){
		self.pagar(artefacto.precio(self))
		self.agregarArtefacto(artefacto)
	}

	method objetivoCumplido(objetivo) { oro += 10 }
}

