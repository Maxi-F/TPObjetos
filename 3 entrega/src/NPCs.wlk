import Personaje.*

class NPC inherits Personaje {
	var dificultad
	
	constructor(unHechizoPreferido, unosArtefactos, unValorBaseDeLucha, unasMonedasDeOro, unaCapacidadDeCarga, unaDificultad) = super(unHechizoPreferido, unosArtefactos, unValorBaseDeLucha, unasMonedasDeOro, unaCapacidadDeCarga) {
		dificultad = unaDificultad
	}
	
	method dificultad(nuevaDificultad) {
		dificultad = nuevaDificultad
	}

	override method habilidadParaLaLucha() = dificultad.multiplo()*(valorBaseDeLucha + self.aporteDeArtefactos())
}

class Dificultad {
	var valorDeMultiplicidad
	
	constructor(unValorDeMultiplicidad){
		valorDeMultiplicidad = unValorDeMultiplicidad
	}
	
	method multiplo() = valorDeMultiplicidad
}

object facil inherits Dificultad(1){ }
object moderado inherits Dificultad(2){ }
object dificil inherits Dificultad(4){ }