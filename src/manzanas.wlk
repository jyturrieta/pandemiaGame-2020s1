import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	
	method cantidadDeHabitantes()
	{
		return personas.size()
	}
	
	
	method agregarHabitante(unaPersona)
	{
		personas.add(unaPersona)
	}
	 	
	
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) 
	{
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) 
	{
		self.personas().remove(persona)
		manzanaDestino.agregarHabitante(persona)
	}
	
	method cantidadContagiadores() 
	{
		return personas.count({p => p.estaInfectada() and not p.estaAislada()})
	}
	
	method cantidadDeInfectados()
	{
		return personas.count({p => p.estaInfectada()})
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	
	method cantidadConSintomas()
	{
		return personas.count({p => p.tieneSintomas()})
	}
	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method image()
	{
		
		return if (self.cantidadDeInfectados() == self.cantidadDeHabitantes())
		{
			"rojo.png"
		}	
		else if (self.cantidadDeInfectados().between(8,self.cantidadDeHabitantes() - 1)) 
		{
			"naranjaOscuro.png"
		}			
		else if (self.cantidadDeInfectados().between(4,7))
		{
			"naranja.png"
		}							
		else if (self.cantidadDeInfectados().between(1,3))
		{
			"amarillo.png"
		}
		else
		{
			"blanco.png"
		}			
	}															
}