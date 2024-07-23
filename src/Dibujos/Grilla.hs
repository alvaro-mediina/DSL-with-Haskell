module Dibujos.Grilla (grillaConf)
where

import Dibujo (Dibujo, figura, apilar, juntar)
import FloatingPic (Output, Conf(..))
import Graphics.Gloss (text, translate, scale)

type Basica = (Int, Int)    

interpBas :: Output Basica
interpBas tupla (x, y) _ _ =  translate x y $ scale 0.15 0.15 $ text $ show tupla

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar 1 (fromIntegral $ length ds) d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar 1 (fromIntegral $ length ds) d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

testAll :: Dibujo Basica
testAll = grilla (map(\y -> (map(\x -> figura(x,y))[0..7]))[0..7])

grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla"
    , pic = testAll
    , bas = interpBas
}