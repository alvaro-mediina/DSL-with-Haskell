module Dibujos.Escher where

import Dibujo (Dibujo (..), apilar, cuarteto, encimar, espejar, figura, juntar, r180, r270, rot45, rotar)
import FloatingPic (Conf (..), Output, zero)
import Graphics.Gloss (Picture (Blank), line, pictures)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

type Escher = Bool

dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar (encimar p2 (rotar p2)) (encimar (r180 p2) (r270 p2))
  where
    p2 = espejar (rot45 p)

dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar p (encimar p2 p3)
  where
    p2 = espejar (rot45 p)
    p3 = r270 p2

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 p = cuarteto (figura False) (figura False) (figura False) (dibujoU p)
esquina n p = cuarteto (esquina (n - 1) p) (lado (n - 1) p) (rotar (lado (n - 1) p)) (dibujoU p)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 p = cuarteto (figura False) (figura False) (rotar (dibujoT p)) (dibujoT p)
lado n p = cuarteto (lado (n - 1) p) (lado (n - 1) p) (rotar (dibujoT p)) (dibujoT p)

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d : ds) = juntar 1 (fromIntegral $ length ds) d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d : ds) = apilar 1 (fromIntegral $ length ds) d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x =
  grilla
    [ [p, q, r],
      [s, t, u],
      [v, w, x]
    ]

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n p =
  noneto
    (esquina n (figura p))
    (lado n (figura p))
    (r270 (esquina n (figura p)))
    (rotar (lado n (figura p)))
    (dibujoU (figura p))
    (r270 (lado n (figura p)))
    (rotar (esquina n (figura p)))
    (r180 (lado n (figura p)))
    (r180 (esquina n (figura p)))

interpBas :: Output Escher
interpBas False _ _ _ = Blank
interpBas True a b c = pictures [line $ map (a V.+) [zero, c, b, zero]]

-- La configuracion de Escher
escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = escher 2 True,
      bas = interpBas
    }
