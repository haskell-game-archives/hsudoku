{-# LANGUAGE OverloadedLabels #-}

-- |
-- Module: Main
-- Description: The main module of the sudoku executable
-- Copyright: (c) Marcel Moosbrugger, 2017
-- License     : MIT
--
-- Contains the main function which sets up the UI of the
-- sudoku executable.
module Main where

import Data.GI.Base
import qualified GI.Gtk as Gtk
import Sudoku.Type
import UserInterface

-- | The main function which opens a new GTK window in which sudoku games can be
-- played.
main :: IO ()
main = do
  _ <- Gtk.init Nothing

  ui <- buildSudokuUI
  cellsBindHandlers (cells ui) (popover ui)
  numbersBindHandlers (numberButtons ui) (popover ui)
  _ <- on (inputClear ui) #clicked $ writePopoverRelativeCell (popover ui) blankval
  _ <- on (inputSolve ui) #clicked $ solvePopoverRelativeCell (popover ui)
  _ <- on (solveButton ui) #clicked $ solveAll (cells ui)
  _ <- on (checkButton ui) #clicked $ checkAll (cells ui)
  gameButtonsBindHandlers (gameButtons ui) (cells ui) (menu ui)
  _ <- on (menuButton ui) #clicked $ showMenu (menu ui) (popover ui)

  #showAll (window ui)
  Gtk.main
