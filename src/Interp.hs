module Interp
  ( interp,
    initial,
    interpApilar,
    interpEncimar,
    interpEspejar,
    interpJuntar,
    interpRot45,
    interpRotar,
  )
where

import Dibujo (Dibujo, foldDib)
import FloatingPic (Conf (..), FloatingPic, Output, grid, half)
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V -- prefijo V para legibilidad

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial (Conf n dib intBas) size = display win white $ withGrid fig size
  where
    win = InWindow n (ceiling size, ceiling size) (0, 0)
    fig = interp intBas dib (0, 0) (size, 0) (0, size)
    desp = -(size / 2)
    withGrid p x = translate desp desp $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 100 100 100 100

-- Interpretación de las figuras básicas
-- utilizo operaciones aritmeticas para Vector (V), distintas a las estandar para numeros
interpRotar :: FloatingPic -> FloatingPic
interpRotar f d w h = f (d V.+ w) h (V.negate w)

interpEspejar :: FloatingPic -> FloatingPic
interpEspejar f d w h = f (d V.+ w) (V.negate w) h

interpRot45 :: FloatingPic -> FloatingPic
interpRot45 f d w h = f (d V.+ half (w V.+ h)) (half (w V.+ h)) (half (h V.- w))

interpApilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpApilar m n f1 f2 d w h = pictures [f1 (d V.+ h') w (r V.* h), f2 d w h'] -- combina las imagenes
  where
    r = m / (m + n)
    r' = n / (m + n)
    h' = r' V.* h

interpJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpJuntar m n f1 f2 d w h = pictures [f1 d w' h, f2 (d V.+ w') (r' V.* w) h]
  where
    r = m / (m + n)
    r' = n / (m + n)
    w' = r V.* w

interpEncimar :: FloatingPic -> FloatingPic -> FloatingPic
interpEncimar f1 f2 d w h = pictures [f1 d w h, f2 d w h]

interp :: Output a -> Output (Dibujo a)
interp b =
  foldDib
    b
    interpRotar
    interpEspejar
    interpRot45
    interpApilar
    interpJuntar
    interpEncimar
