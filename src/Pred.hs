module Pred (Pred, cambiar, anyDib, allDib, orP, andP, falla) where

import Dibujo (Dibujo (..), change, foldDib)

type Pred a = a -> Bool

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar p f dibujo = change (\x -> if p x then f x else (Figura x)) dibujo

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p dib = foldDib p (False ||) (False ||) (False ||) (\_ _ a b -> a || b) (\_ _ a b -> a || b) (||) dib

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib p dib = foldDib p (True &&) (True &&) (True &&) (\_ _ a b -> a && b) (\_ _ a b -> a && b) (&&) dib

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP p1 p2 x = p1 x && p2 x

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP p1 p2 x = p1 x || p2 x

falla :: Bool
falla = True