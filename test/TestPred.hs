module Main (main) where

import Test.HUnit
import Pred (anyDib, allDib, andP, orP, cambiar)
import Dibujo

testCambio :: Test
testCambio = TestCase (assertEqual "cambiar (==1) (const (Figura 2)) (Figura 1)" (Figura (2 :: Integer)) (cambiar (==1) (const (Figura 2)) (Figura 1)))

testAnyDib :: Test
testAnyDib = TestCase (assertBool "anyDib (==1) (Figura 1)" (anyDib (==(1 :: Integer)) (Figura 1)))

testAllDib :: Test
testAllDib = TestCase (assertBool "allDib (==1) (Figura 1)" (allDib (==(1 :: Integer)) (Figura 1)))

testAndP :: Test
testAndP = TestCase (assertBool "andP (>0) (<2) 1" (andP ((>0) :: Integer -> Bool) (<2) 1))

testOrP :: Test
testOrP = TestCase (assertBool "orP (>0) (<0) 1" (orP ((>0) :: Integer -> Bool) (<0) 1))

-- Agrupamos todos los tests en una lista
tests :: Test
tests = TestList [testCambio, testAnyDib, testAllDib, testAndP, testOrP]

-- Ejecutamos los tests
main :: IO Counts
main = runTestTT tests

