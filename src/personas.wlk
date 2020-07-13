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
}

