class Comerciante{
	var categoria
	var property comision
	var property minimoNoImponible
	
	constructor(unaCategoria, unaComision, unMinimoNoImponible){
		categoria = unaCategoria
		comision = unaComision
		minimoNoImponible = unMinimoNoImponible
	}
	
	method impuestoAdicionalSobre(unArtefacto){
		return categoria.impuestoAdicional(unArtefacto, self)
	}
	
	method cambiarSituacionImpositiva(nuevaCategoria){ categoria = nuevaCategoria }
	
	method recategorizacion(){ categoria.recategorizar(self) }
	
	method superaElLimite() = comision > 0.21

	method duplicarComision(){ comision *= 2 }	
}

object independiente{

	method impuestoAdicional(artefacto, comerciante) = comerciante.comision()
	
	method recategorizar(comerciante){
		comerciante.duplicarComision()
		if(comerciante.superaElLimite())
			comerciante.cambiarSituacionImpositiva(registrado)
	}
}

object registrado{

	method impuestoAdicional(artefacto, comerciante) = artefacto.precio("unPortador") * 0.21
	
	method recategorizar(comerciante){
		comerciante.cambiarSituacionImpositiva(conImpuestoALasGanancias)
	}

}

object conImpuestoALasGanancias{

	method impuestoAdicional(artefacto, comerciante){
		if(artefacto.precio("unPortador") > comerciante.minimoNoImponible())
			return (artefacto.precio("unPortador") - comerciante.minimoNoImponible())*0.35
		else
			return 0
	}
	
	method recategorizar(comerciante){}
}