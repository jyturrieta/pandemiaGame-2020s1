object agenteDeSalud 
{
	var property position
	var property image = "doctormario.png"
	
	method moverse(pos)
	{
		self.position(pos)
	}
	
	method moverseArriba() {
		self.moverse(self.position().up(1))
	}

	method moverseAbajo() {
		self.moverse(self.position().down(1))
	}
	
	method moverseIzquierda() {
		self.moverse(self.position().left(1))
	}
	
	method moverseDerecha() {
		self.moverse(self.position().right(1))
	}
}

