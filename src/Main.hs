module Main (main) where

import Dibujos.Feo (feoConf)
import Dibujos.Grilla (grillaConf)
import Dibujos.Escher (escherConf)
import FloatingPic (Conf(..))
import Interp (initial)
import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)
import Control.Monad (when)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [feoConf, grillaConf, escherConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' drawings nameToFind =
  case findDrawing nameToFind drawings of
    Just conf -> initial conf 800
    Nothing -> putStrLn $ "No hay un dibujo llamado " ++ nameToFind

-- Función para imprimir la lista de dibujos disponibles
printAvailableDrawings :: [Conf] -> IO ()
printAvailableDrawings drawings = do
  putStrLn "Los dibujos disponibles son:"
  mapM_ (\(i, conf) -> putStrLn $ show i ++ ". " ++ name conf) $ zipWith addIndex [1..] drawings
  where
    addIndex :: Int -> Conf -> (Int, Conf)
    addIndex idx conf = (idx, conf)


-- Función principal del programa
main :: IO ()
main = do
  args <- getArgs
  when (length args > 1 || null args) $ do
    putStrLn "Para ver los dibujos use 'lista'."
    exitFailure
  when (head args == "lista") $ do
    printAvailableDrawings configs
    putStrLn "Elija el número del dibujo que desea ver (o '0' para salir):"
    handleSelection
    exitSuccess
  initial' configs (head args)

-- Función para manejar la selección del usuario
handleSelection :: IO ()
handleSelection = do
  input <- getLine
  case input of
    "0" -> do
      putStrLn "Saliendo del programa..."
      exitSuccess
    _ -> do
      let choice = read input :: Int
      if choice >= 1 && choice <= length configs
        then initial' configs (name (configs !! (choice - 1)))
        else do
          putStrLn "Número de dibujo no válido. Intente nuevamente:"
          handleSelection

-- Función para encontrar un dibujo por su nombre
findDrawing :: String -> [Conf] -> Maybe Conf
findDrawing _ [] = Nothing
findDrawing nameToFind (c:cs) =
  if nameToFind == name c
    then Just c
    else findDrawing nameToFind cs
