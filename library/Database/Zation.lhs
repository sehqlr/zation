> -- | An example module.
> module Zation (main) where

> import Parser
> import Text.Parsec (parse)

> -- | An example function.
> main :: IO ()
> main = print (parse headline "test" "* Breaking News, Zation can parse org-mode headlines, sorta")
