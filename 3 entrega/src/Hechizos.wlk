class PesoExtraDeHechizo {
	method pesoExtra() {
		if(self.poder().even()) {
			return 2
		}
		else {
			return 1
		}
	}
	
	method poder()
}

class HechizoDeLogos inherits PesoExtraDeHechizo{
	var nombre
	var multiplo
	
	constructor(unNombre, unMultiplo){
		nombre = unNombre
		multiplo = unMultiplo
	}
	
	method cambiarNombre(nuevoNombre) { 
		nombre = nuevoNombre
	}
	
	override method poder() = nombre.size() * multiplo
	
	method esHechizoPoderoso() = self.poder() > 15
	
	method valorDelRefuerzo(portador) = self.poder()
	
	method precio(portador) = self.poder()

	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura + self.precio(portador)
}

class HechizoComercial inherits HechizoDeLogos {
	var porcentaje;
	
	constructor(unNombre, unMultiplo, unPorcentaje) = super(unNombre, unMultiplo){
		porcentaje = unPorcentaje
	}
	
	override method poder() = (porcentaje * nombre.size()) * multiplo
}

object hechizoBasico inherits PesoExtraDeHechizo{
	override method poder() = 10
	
	method esHechizoPoderoso() = false
	
	method valorDelRefuerzo(portador) = self.poder()
	
	method precio(portador) = 10
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura + self.precio(portador)
}

