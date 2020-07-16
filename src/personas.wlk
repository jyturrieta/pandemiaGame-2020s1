import manzanas.*
import simulacion.*


class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property diaDeInfeccion = 0
	var property respetaLaCuarentena = false
	var property tieneSintomas = false
	
	method infectarse() 
	{
		diaDeInfeccion = simulacion.diaActual()
		estaInfectada = true
	}
	
	method curarse()
	{
		if ( self.estaInfectada() ) 
		{
			if ( (self.diaDeInfeccion() - simulacion.diaActual()).abs() == simulacion.duracionInfeccion() )
			{
			estaInfectada = false
			tieneSintomas = false
			estaAislada = false
			diaDeInfeccion = 0
			}
		}
	}
	
	
}

