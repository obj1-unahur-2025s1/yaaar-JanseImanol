import barcosPiratas.*

class Mision{
    method barcoUtil(unBarco) = unBarco.tripulacion().size() >= unBarco.capacidad() *0.90 

}

class Busqueda inherits Mision{
    method pirataUtil(unPirata) = unPirata.items().contains("brujula") ||
        unPirata.items().contais("mapa") ||
        unPirata.items().contains("botella de grogXD") and
        unPirata.dinero() < 5

    override method barcoUtil(unBarco) = super(unBarco) and unBarco.tripulantes().contains({t=>t.items().contains("cofre de tesoro")})
}

class Leyenda inherits Mision{
    var itenNesesario
    method pirataUtil(unPirata) =  unPirata.items().size() >= 10 and unPirata.items().contains(itenNesesario)
 
}

class Saqueo inherits Mision{
    const victima

    method pirataUtil(unPirata) =  unPirata.dinero() < dineroParaSaqueo.dinero() and
        unPirata.pudeAtacar(victima)

    override method barcoUtil(unBarco) = super(unBarco) and victima.esVulnerable(unBarco)
}

object dineroParaSaqueo {
    var property dinero = 3
}