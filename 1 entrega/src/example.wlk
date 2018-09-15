/** First Wollok example */
object fuerzaOscura {
	var poder = 5
	
	method eclipse() {
		poder *= 2
	}
	
	method valor() {
		return poder
	}
}

object rolando {
	var hechizoPreferido = espectroMalefico
	var artefactos = []
	var valorBaseDeLucha = 1
	
	method nivelDeHechiceria() {
		return (3*hechizoPreferido.poder()) + fuerzaOscura.valor()
	}
	
	method cambiarHechizoPreferido(nuevoHechizo) {
		hechizoPreferido = nuevoHechizo
	}
	
	method esPoderoso() {
		return hechizoPreferido.esHechizoPoderoso()
	}
	
	method agregarArtefacto(nuevoArtefacto){
		artefactos.add(nuevoArtefacto)
	}
	
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	
	method removerTodosLosArtefactos(){
		artefactos.clear()
	}
	
	method valorBaseDeLucha(){
		return valorBaseDeLucha
	}
	method modificarValorBaseDeLucha(nuevoValorBaseDeLucha){
		valorBaseDeLucha = nuevoValorBaseDeLucha
	}
	
	method aporteDeArtefactos(){
		return artefactos.map({unArtefacto => unArtefacto.unidadesDeLucha()}).sum()
	}
	
	method habilidadParaLaLucha(){
		return (valorBaseDeLucha + (self.aporteDeArtefactos()))
	}
	
	method habilidadEsMayorQueHechiceria(){
		return self.habilidadParaLaLucha() > self.nivelDeHechiceria()
	}
}

object espectroMalefico {
	var nombre = "Espectro Malefico"
	
	method cambiarNombre(nuevoNombre) {
		nombre = nuevoNombre
	}
	
	method poder() {
		return nombre.size()
	}
	
	method esHechizoPoderoso() {
		return self.poder() > 15
	}
}

object hechizoBasico {
	method cambiarNombre(nuevoNombre) {}
	
	method poder() {
		return 10
	}
	
	method esHechizoPoderoso() {
		return false
	}
}

object espadaDelDestino{
	
	method unidadesDeLucha(){
		return 3
	}
}

object collarDivino{
	var perlas = 6
	
	method cantidadDePerlas(cantidad){
		perlas = cantidad
	}
	
	method unidadesDeLucha(){
		return perlas
	}
}

object mascaraOscura{
	
	method unidadesDeLucha(){
		return (4.max(0.5*fuerzaOscura.valor()))
	}
}

