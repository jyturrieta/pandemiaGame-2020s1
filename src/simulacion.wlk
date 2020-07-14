import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaLaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}
	
	method chanceDeTenerSintomas()
	{
		return self.tomarChance(self.chanceDePresentarSintomas())
	}
	
	method crearPersona()
	{
        return new Persona()  
    }
    
    method pasarUnDia()
    {
    	diaActual += 1
    	manzanas.forEach({m => m.pasarUnDia()})
    	console.println("terminó el día: " + (self.diaActual() - 1)) 
    	
    }
    
	method cantidadTotalDePersonas()
	{
		return manzanas.sum({manzana => manzana.cantidadDeHabitantes()})
	}
	   
	method cantidadTotalDeInfectados()
	{
		return manzanas.sum({manzana => manzana.cantidadDeInfectados()})
	}   
	
	method cantidadTotalConSintomas()
	{
		return manzanas.sum({manzana => manzana.cantidadConSintomas()})
	}
    
	method crearManzana() 
	{
		const nuevaManzana = new Manzana()
		(1..self.personasPorManzana()).forEach({m => nuevaManzana.agregarHabitante(self.crearPersona())})
		return nuevaManzana
	}
	method estadoDeSimulacion() 
	{
		 console.println("Día: " + self.diaActual() + " total de personas: " + self.cantidadTotalDePersonas() + " Infectados: "
		 	+ self.cantidadTotalDeInfectados() + " Con sintomas: " + self.cantidadTotalConSintomas()) 
	}
	
	method agregarInfectado()
	{
		const infectado = new Persona()
		infectado.infectarse()
		self.agregarPersonaEnCualquierManzana(infectado)
	}
	
	method agregarPersonaEnCualquierManzana(unaPersona)
	{
		const unaManzana = manzanas.anyOne()
		unaManzana.agregarHabitante(unaPersona)
	}
	
	method obtenerManzana(pos)
	{
		return manzanas.find({m => m.position() == pos})
	}
}
