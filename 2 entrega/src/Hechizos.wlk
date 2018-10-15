class HechizoDeLogos {
	var nombre
	var multiplo
	
	constructor(unNombre, unMultiplo){
		nombre = unNombre
		multiplo = unMultiplo
	}
	
	method cambiarNombre(nuevoNombre) { 
		nombre = nuevoNombre
	}
	
	method poder() = nombre.size() * multiplo
	
	method esHechizoPoderoso() = self.poder() > 15
	
	method valorDelRefuerzo(portador) = self.poder()
	
	method precio(portador) = self.poder()

	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura + self.precio(portador)
}

object hechizoBasico {
	method poder() = 10
	
	method esHechizoPoderoso() = false
	
	method valorDelRefuerzo(portador) = self.poder()
	
	method precio(portador) = 10
	
	method precioDelRefuerzo(portador, valorBaseDeArmadura) = valorBaseDeArmadura + self.precio(portador)
}

