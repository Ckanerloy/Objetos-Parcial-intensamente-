/** First Wollok example */
class Persona{
	var property felicidad=1000 
	var property emocionDominante
	const recuerdosDelDia =[]
	const recuerdosCentrales=#{}
	
	method agregaRecuerdo(unRecuerdo){
		recuerdosDelDia.add(unRecuerdo)
	}

	method vivi(unEvento){
		self.agregaRecuerdo(new Recuerdo(evento=unEvento, emocionDominante=self.emocionDominante()))
	}
	
	method recuerdasElEvento(unEvento)=recuerdosDelDia.any({recuerdo=>recuerdo.eventoAsociado(unEvento)})

	method agregarPensamientoCentral(recuerdo){
		recuerdosCentrales.add(recuerdo)
	}
	method disminuirFelicidad(nuevaFelicidad){
		if(nuevaFelicidad<1){
			self.error("No puede ser inferior a 1")
		}else{
			felicidad=nuevaFelicidad	
		}
	}
	
	method ultimos5Recuerdos() = self.recuerdosOrdenadosPorFechaDescendente().take(5)
	
	method recuerdosOrdenadosPorFechaDescendente() = recuerdosDelDia.sortedBy({recuerdo1, recuerdo2 => recuerdo1.fecha() >= recuerdo2.fecha()})
	
	method pensamientoCentralMasDificil()=recuerdosCentrales.filter({recuerdo=>recuerdo.dificilDeExplicar()})
	
	method negas(unRecuerdo)=emocionDominante.niegaRecuerdo(emocionDominante)
}

class Evento{
	var property descripcion
	
	method cantidadPalabras()=self.descripcion().words().size()
}

class Recuerdo{
	var property evento
	var property emocionDominante
	var property fecha= new Date()
	var property yaTeAsentaste = false
	
	method eventoAsociado(unEvento)=evento==unEvento
	
	method asentateEn(unPersonaje){
		if(self.yaTeAsentaste().negate()) {
			emocionDominante.asentateEn(unPersonaje, self)
			self.yaTeAsentaste(true)
		}
	}
	
	method dificilDeExplicar()=evento.cantidadPalabras()>10
	
	method sosAlegre() = emocionDominante.sosAlegre()
}

//class Sentimiento{
//	method asentateEn(unPersonaje,recuerdo)
//}

class Alegria{
	method asentateEn(unPersonaje,recuerdo){
		if(unPersonaje.felicidad()>500){
			unPersonaje.agregarPensamientoCentral(recuerdo)
		}
	}
	
	method sosAlegre() = true
	method negas(unRecuerdo) = unRecuerdo.sosAlegre().negated()

}

class Tristeza{
	method asentateEn(unPersonaje,recuerdo){
		unPersonaje.felicidad(unPersonaje.felicidad() * 0.9)
		unPersonaje.agregarPensamientoCentral(recuerdo)
	}
	method sosAlegre() = false
	method negas(unRecuerdo)= unRecuerdo.sosAlegre()
		
}

class Disgusto{
	method asentateEn(unPersonaje,recuerdo){	
	}
	method sosAlegre()=false
	method negas()=true
}

class Furia{
	method asentateEn(unPersonaje,recuerdo){
	}
	method sosAlegre()=false
	method negas()=true
}

class Temor{
	method asentateEn(unPersonaje,recuerdo){
	}
	method sosAlegre()=false
	method negas()=true
}
