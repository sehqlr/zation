> module Database.Zation.Types where

Importing containers to define types

I played around with using the type system to define trees and association
lists, I'm going to use the containers package so I don't have to implement
functions for those data structures.

> import Data.Tree

I'm going to alias the types for the Outline type because I want the terms to
match up with https://orgmode.org/worg/dev/org-syntax.html

> data Outline = Section String
>              | Headline Int String
>   deriving (Read, Show)

I don't know what type declaration I should use, so I'll use the alias one for
now

> type Document = Tree Outline

type Properties = Map String String

My plan is to have properties on the root of the tree, with the file
name/path has the headline; that means that I can have the document options as
properties on the root node. That kinda works with how Org works right now,
where you can have overrides to top-level options in properties on a subtree.
AND, that means if I have the same tree structure for files in directories, I
can implement directory variables as properties as well. Woah!

