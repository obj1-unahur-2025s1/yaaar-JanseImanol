class Pirata {
  const property items = []

  var nivelEbriedad = 0
  var dinero = 0

  method agregarItem(unItem) {items.add(unItem)}
  method nivelEbriedad() = nivelEbriedad
  method dinero() = dinero 
  method estaPasado() = nivelEbriedad >= 90
  method tieneLLaveCofre() = items.contains("llave de cofre")
  method esUtil(mision) = mision.pirataUtil(self)
  method puedeAtacar(unaVictima) = unaVictima.pudeSerAtacado(self)  

  method tomarTrago() {
    if (dinero > 0){
      dinero -= 1
      nivelEbriedad += 5
    }
  }
}

class Espia inherits Pirata{
  override method estaPasado() = false 
  method tienePermiso() = self.items().contains("permiso de la corona")
  override method puedeAtacar(unaVictima) = super(unaVictima) and self.tienePermiso()

}

class Barco{

  const property tripulacion = []
  const capacidad
  var mision 

  method estanTodosPasados() = tripulacion.all({p=>p.estaPasado()}) 
  method esVulnerable(unBarco) = unBarco.tripulacion().size() > tripulacion.size() *0.5 
  method pirataMasEbrio() = tripulacion.max({p=>p.nivelEbriedad()})

  method agregarTripulante(unPirata) { // solo si puede hacer la mision
    if(mision.pirataUtil(unPirata) and tripulacion.size() < capacidad){
      tripulacion.add(unPirata)
    }
  }

  method cambiarMision(nuevaMision) {
    mision = nuevaMision
    tripulacion.forEach({p=> if (!p.esUtil(nuevaMision)) tripulacion.remove(p)})
  }

  method anclarEnCiudad(unaCiudad){
    tripulacion.forEach({p=>p.tomarTrago()})
    tripulacion.remove(self.pirataMasEbrio())
    unaCiudad.sumarHabitante()
  }

  method esTemible() = mision.barcoUtil(self) and tripulacion.all({p=>p.esUtil(mision)})
  method cantTripulantesPasados() = tripulacion.count({p=>p.estaPasado()})
  method pudeSerAtacado(unPirata) =  unPirata.estaPasado()
  method tripulantesPasados() = tripulacion.filter({p=>p.estaPasado()})
  method itemsDePasados() = self.tripulantesPasados().forEach({p=>p.items()}.asSet())
  method pasadoConMasDinero() = self.tripulantesPasados().max({p=>p.dinero()})  

}

class CiudadCostera{
  var habitantes

  method sumarHabitante() {
    habitantes += 1
  }
  method esVulnerable(unBarco) = unBarco.tripulacion().size() >= habitantes * 0.4 || unBarco.estanTodosPasados()
  method pudeSerAtacado(unPirata) =  unPirata.nivelEbriedad() > 50


}
