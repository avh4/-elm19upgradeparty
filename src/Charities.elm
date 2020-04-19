module Charities exposing (..)

{-| A library of different charities that have been supported in the past.
-}


type alias CharityInfo =
    { name : String
    , description : String
    , donateLink : String
    }


annieCannons : CharityInfo
annieCannons =
    { name = "AnnieCannons"
    , description = "Transforming survivors of human trafficking into software professionals"
    , donateLink = "https://is.gd/jojipi"
    }


blackGirlsCode : CharityInfo
blackGirlsCode =
    { name = "Black Girls Code"
    , description = "Introducing computer coding lessons to young girls from underrepresented communities"
    , donateLink = "https://bit.ly/blackgirlsarethefuture"
    }
