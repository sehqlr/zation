> {-# LANGUAGE OverloadedStrings #-}
> module Database.Zation.Printer (indent) where

The first thing I need to do in this module is to import prettyprinter and the
zation types

> import Data.Text.Prettyprint.Doc
> import Database.Zation.Types

Use the level from the Headline, and put that into the nest function

> indent' :: Outline -> Doc ann

For the Section case, append the string with a line

> indent' (Section str) = pretty str <> line

For the Headline case, use hang function. The hardcoded 2 there, assuming that
this code is actually right, should be replaced with user-defined variable for
indentation

> indent' (Headline lvl title) = hang (lvl*2) "*" <> space <> pretty title <> hardline

In order to get more of the Document printed, I'm probably going to use a Tree
to List function mentioned in the containers documentation, and a variant of
concatWith from the prettyprinter package to apply these functions to the whole
tree. The printers that I'll need for this are mostly going to be operating on
the Tree part of the data, not the Outline part for now. The Outline is going to
contain things like text formatting annotations and whatnot.
