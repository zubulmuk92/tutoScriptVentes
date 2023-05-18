zbBicrave = {}

-- Modifier les prix de ventes des différentes drogues
zbBicrave.prixVente= {
    weed=100,
    meth=200,
    cocaine=300,
}
-- Modifier le nombre de drogues vendus par vente
zbBicrave.nombreVente= {
    minimum=1,
    maximum=3,
}

-- Modifier le nom de l'item que vous vendez
zbBicrave.nomVente = {
    weed="weed_pooch",
    meth="meth_pooch",
    coke="coke_pooch",
}
-- Modifier la zone de vente
zbBicrave.zoneVente= {
    -- radius => detection du pnj ( le cercle )
    radius=6.05,

    -- distanceVente => possibilité de vente ( le rond )
    distanceVente=1.5,

    -- cooldown => attente entre chaque ventes ( en s )
    cooldown=5,
}

-- Modifier le temps de l'animation ( en s )
zbBicrave.tempsAnimation=7