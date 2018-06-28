> -- | An example module.
> module Database.Zation (main) where

> import Database.Zation.Parser
> import Text.Parsec (parse)

> -- | An example function.
> main :: IO ()
> main = print (parse outline "test" "* Breaking News, Zation can parse org-mode headlines, sorta")
