module Dibujo
  ( Dibujo (..),
    figura,
    encimar,
    apilar,
    juntar,
    rot45,
    rotar,
    espejar,
    mapDib,
    change,
    foldDib,
    cuarteto,
    figuras,
    r180,
    r270,
    encimar4,
    ciclar,
    TrioRectoCir (..),
  )
where

-- Nuestro lenguaje

data Dibujo a
  = Figura a
  | Rotar (Dibujo a)
  | Espejar (Dibujo a)
  | Rot45 (Dibujo a)
  | Apilar Float Float (Dibujo a) (Dibujo a)
  | Juntar Float Float (Dibujo a) (Dibujo a)
  | Encimar (Dibujo a) (Dibujo a)
  deriving (Eq, Show)

data TrioRectoCir = Triangulo | Rectangulo | Circulo deriving (Eq, Show)

-- combinadores
infixr 6 ^^^

infixr 7 .-.

infixr 8 ///

comp :: Int -> (a -> a) -> a -> a
comp 1 f = f
comp n f = f . comp (n - 1) f

-- Funciones constructoras
figura :: a -> Dibujo a
figura = Figura

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar = Juntar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45

rotar :: Dibujo a -> Dibujo a
rotar = Rotar

espejar :: Dibujo a -> Dibujo a
espejar = Espejar

-- Superpone un dibujo con otro
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = Encimar

-- Pone el primer dibujo arriba del segundo, ambos ocupan el mismo espacio
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = Apilar 1.0 1.0

-- Pone un dibujo al lado del otro, ambos ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = Juntar 1.0 1.0

-- rotaciones
r180 :: Dibujo a -> Dibujo a
r180 = comp 2 Rotar

r270 :: Dibujo a -> Dibujo a
r270 = comp 3 Rotar

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 a = (^^^) a ((^^^) ((^^^) (rotar a) (r180 a)) (r270 a))

-- cuatro figuras en un cuadrante.
-- Junta a con b, c con d, luego apila ab cd
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = (.-.) ((///) a b) ((///) c d)

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar a = cuarteto a (rot45 a) (rotar a) (r270 a)

-- map para nuestro lenguaje
-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Figura a) = Figura (f a)
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar x y a b) = Apilar x y (mapDib f a) (mapDib f b)
mapDib f (Juntar x y a b) = Juntar x y (mapDib f a) (mapDib f b)
mapDib f (Encimar a b) = Encimar (mapDib f a) (mapDib f b)

-- Cambiar todas las básicas de acuerdo a la función.
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change f (Figura a) = f a
change f (Rotar a) = Rotar (change f a)
change f (Espejar a) = Espejar (change f a)
change f (Rot45 a) = Rot45 (change f a)
change f (Apilar x y a b) = Apilar x y (change f a) (change f b)
change f (Juntar x y a b) = Juntar x y (change f a) (change f b)
change f (Encimar a b) = Encimar (change f a) (change f b)

-- Principio de recursión para Dibujos.
foldDib ::
  (a -> b) ->
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b
foldDib f _ _ _ _ _ _ (Figura a) = f a
foldDib f g h i j k l (Rotar a) = g (foldDib f g h i j k l a)
foldDib f g h i j k l (Espejar a) = h (foldDib f g h i j k l a)
foldDib f g h i j k l (Rot45 a) = i (foldDib f g h i j k l a)
foldDib f g h i j k l (Apilar x y a b) = j x y (foldDib f g h i j k l a) (foldDib f g h i j k l b)
foldDib f g h i j k l (Juntar x y a b) = k x y (foldDib f g h i j k l a) (foldDib f g h i j k l b)
foldDib f g h i j k l (Encimar a b) = l (foldDib f g h i j k l a) (foldDib f g h i j k l b)

-- Extrae todas las figuras básicas del dibujo
figuras :: Dibujo a -> [a]
figuras (Figura a) = [a]
figuras (Rotar a) = figuras a
figuras (Espejar a) = figuras a
figuras (Rot45 a) = figuras a
figuras (Apilar _ _ a b) = figuras a ++ figuras b
figuras (Juntar _ _ a b) = figuras a ++ figuras b
figuras (Encimar a b) = figuras a ++ figuras b
