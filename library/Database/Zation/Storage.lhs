> module Database.Zation.Storage (Tree) where

I'm going to try to use the question from SO to help me
https://stackoverflow.com/questions/4431809/trees-in-haskell

> data Tree a = Leaf a | Branch [Property] [Tree a] deriving (Show, Read)

> type Property = (String, String)

My plan is to have properties on the root of the tree, with the file
name/path has the "headline"; that means that I can have the document options as
properties on the root node. That kinda works with how Org works right now,
where you can have overrides to top-level options in properties on a subtree.
AND, that means if I have the same tree structure for files in directories, I
can implement directory variables as properties as well. Woah!

I'm going to have a separate function to pretty-print the Tree in org-mode
syntax so that the output of show for Tree is valid Haskell code, as suggested
by Real World Haskell.

