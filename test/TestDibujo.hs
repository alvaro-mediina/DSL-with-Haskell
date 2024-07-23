module Main (main) where
import Test.HUnit
import Dibujo (Dibujo(..),espejar, figura, encimar, apilar, juntar, rotar, rot45, TrioRectoCir(..))


-- Test para la función figura
testFigura :: Test
testFigura = TestCase $ assertEqual "figura Triangulo" (Figura Triangulo) (figura Triangulo)

-- Test para la función encimar
testEncimar :: Test
testEncimar = TestCase $ assertEqual "encimar Figura Triangulo y Figura Rectangulo" (Encimar (Figura Triangulo) (Figura Rectangulo)) (encimar (Figura Triangulo) (Figura Rectangulo))

-- Test para la función apilar
testApilar :: Test
testApilar = TestCase $ assertEqual "apilar 1.0 1.0 Figura Triangulo y Figura Rectangulo" (Apilar 1.0 1.0 (Figura Triangulo) (Figura Rectangulo)) (apilar 1.0 1.0 (Figura Triangulo) (Figura Rectangulo))

-- Test para la función juntar
testJuntar :: Test
testJuntar = TestCase $ assertEqual "juntar 1.0 1.0 Figura Triangulo y Figura Rectangulo" (Juntar 1.0 1.0 (Figura Triangulo) (Figura Rectangulo)) (juntar 1.0 1.0 (Figura Triangulo) (Figura Rectangulo))

-- Test para la función rot45
testRot45 :: Test
testRot45 = TestCase $ assertEqual "rot45 Figura Triangulo" (Rot45 (Figura Triangulo)) (rot45 (Figura Triangulo))

-- Test para la función rotar
testRotar :: Test
testRotar = TestCase $ assertEqual "rotar Figura Triangulo" (Rotar (Figura Triangulo)) (rotar (Figura Triangulo))

-- Test para la función espejar
testEspejar :: Test
testEspejar = TestCase $ assertEqual "espejar Figura Triangulo" (Espejar (Figura Triangulo)) (espejar (Figura Triangulo))

-- Agrupamos todos los tests en una lista
tests :: Test
tests = TestList [testFigura, testEncimar, testApilar, testJuntar, testRot45, testRotar, testEspejar]

-- Ejecutamos los tests
main :: IO Counts
main = runTestTT tests