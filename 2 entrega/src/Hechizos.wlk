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
}

object hechizoBasico {
	method poder() = 10
	
	method esHechizoPoderoso() = false
	
	method valorDelRefuerzo(portador) = self.poder()
}

