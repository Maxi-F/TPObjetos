/*       _______________________________________________________________________
	|:..                         TP  OBJETOS                   ``:::%%%%%%%%|
	|%%%:::::..         Expertos en Lucha y Hechiceria            `:::::%%%%|
	|%%%%%%%:::::.....________________________________________________::::::|
	
	

		  CUANDO EL TUTOR TE DICE QUE LOS IF SON SACRILEGIO
			  
	                                                     ___,------, 
	             _,--.---.                         __,--'         / 
	           ,' _,'_`._ \                    _,-'           ___,| 
	          ;--'       `^-.                ,'        __,---'   || 
	        ,'               \             ,'      _,-'          || 
	       /                  \         _,'     ,-'              || 
	      :                    .      ,'     _,'                 |: 
	      |                    :     `.    ,'                    |: 
	      |           _,-      |       `-,'                      :: 
	     ,'____ ,  ,-'  `.   , |,         `.                     : \ 
	     ,'    `-,'       ) / \/ \          \                     : : 
	     |      _\   o _,-'    '-.           `.                    \ \ 
	      `o_,-'  `-,-' ____   ,` )-.______,'  `.                   : : 
	       \-\    _,---'    `-. -'.\  `.  /     `.                  \  \ 
	        / `--'             `.   \   \:        \                  \,.\ 
	       (              ____,  \  |    \\        \                 :\ \\ 
	        )         _,-'    `   | |    | \        \                 \\_\\ 
	       /      _,-'            | |   ,'-`._      _\                 \,' 
	       `-----' |`-.           ;/   (__ ,' `-. _;-'`\           _,--' 
		     ,'        |   `._     _,' \-._/  Y    ,-'      \
	    /        _ |      `---'    :,-|   |    `     _,-'\_,--'   \ 
	   :          `|       \`-._   /  |   '     `.,-' `._`         \ 
	   |           _\_    _,\/ _,-'|                     `-._       \ 
	   :   ,-         `.-'_,--'    \                         `       \ 
	   | ,'           ,--'      _,--\           _,                    : 
	    )         .    \___,---'   ) `-.____,--'                      | 
	   _\    .     `    ||        :            \                      ; 
	 ,'  \    `.    )--' ;        |             `-.                  / 
	|     \     ;--^._,-'         |                `-._            _/_\ 
	\    ,'`---'                  |                    `--._____,-'_'  \ 
	 \_,'                         `._                          _,-'     ` 
	                            ,-'  `---.___           __,---' 
	                          ,'             `---------' 
	                        ,' 

*/

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
	
	method pertenenciaMasPoderosa() = artefactos.filter({unArtefacto => unArtefacto.noEsEspejo()}).max({unArtefacto => unArtefacto.unidadesDeLucha(self)})
	
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

