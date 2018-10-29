/*   _______________________________________________________________________
	|:..                         TP  OBJETOS                   ``:::%%%%%%%%|
	|%%%:::::..        Lucha y Hechiceria en el Mercado           `:::::%%%%|
	|%%%%%%%:::::.....________________________________________________::::::|
	
	
								
								INSERT ASCII


*/

import FuerzaOscura.*
import ObjetosDeLucha.*
import Hechizos.*
import Excepciones.*

class Personaje {
	var hechizoPreferido
	var artefactos
	var property valorBaseDeLucha
	var property oro
	var capacidadDeCarga
	
	constructor(unHechizoPreferido, unosArtefactos, unValorBaseDeLucha, unasMonedasDeOro, unaCapacidadDeCarga) {
		hechizoPreferido = unHechizoPreferido
		artefactos = unosArtefactos
		valorBaseDeLucha = unValorBaseDeLucha
		oro = unasMonedasDeOro
		capacidadDeCarga = unaCapacidadDeCarga
	}
	
	method nivelDeHechiceria() = 3 * hechizoPreferido.poder() + fuerzaOscura.valor()
	
	method cambiarHechizoPreferido(nuevoHechizo) { hechizoPreferido = nuevoHechizo }
	
	method esPoderoso() = hechizoPreferido.esHechizoPoderoso()
	
	method agregarArtefacto(nuevoArtefacto) { 
		if((capacidadDeCarga - self.cantidadDeCarga()) < nuevoArtefacto.pesoTotal(self)) {
			throw new ExcepcionPorCargaMaxima("La cantidad de peso del artefacto excede la cantidad de carga maxima.")
		} 
		else {
			artefactos.add(nuevoArtefacto)	
		}
	}
	
	method cantidadDeCarga() = artefactos.sum({artefacto => artefacto.pesoTotal(self)})
	
	method removerArtefacto(artefacto) { artefactos.remove(artefacto) }
	
	method removerTodosLosArtefactos() { artefactos.clear() }
	
	method aporteDeArtefactos() = artefactos.sum({unArtefacto => unArtefacto.unidadesDeLucha(self)})
	
	method habilidadParaLaLucha() = valorBaseDeLucha + self.aporteDeArtefactos()
	
	method habilidadEsMayorQueHechiceria() = self.habilidadParaLaLucha() > self.nivelDeHechiceria()
	
	method soloTieneAlEspejo() = artefactos == [new Espejo(0,0)]
	
	method pertenenciaMasPoderosa() = artefactos.filter({unArtefacto => unArtefacto.noEsEspejo()}).max({unArtefacto => unArtefacto.unidadesDeLucha(self)})
	
	method unidadesDeLuchaDePertenenciaMasPoderosa() = self.pertenenciaMasPoderosa().unidadesDeLucha(self)
	
	method cantidadDeArtefactos() = artefactos.size()
	
	method estaCargado() = self.cantidadDeArtefactos() >= 5

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
	
	method comprarArtefacto(artefacto, comerciante){
		self.pagar(artefacto.precio(self) + comerciante.impuestoAdicionalSobre(artefacto))
		self.agregarArtefacto(artefacto)
	}

	method objetivoCumplido(objetivo) { oro += 10 }
}

