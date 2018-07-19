This is the Parser module for zation

> module Database.Zation.Parser (
>   ParseTree(Text,Outline), outline
> ) where

/IMPORTS/

First, we need to import a parser combinator library. I started with the base
library to follow along with the tutorial I found
(https://two-wrongs.com/parser-combinators-parsing-for-haskell-beginners), to
learn the concepts. I _think_ I'm ready to start using Parsec, but I may have to
abandon that if I get overwhelmed.

> import Control.Applicative ( (<$>) )
> import Text.Parsec
> import Text.Parsec.Char ()

/TYPES/

The reason why I feel we need a separate ParseTree from the Storage.Tree is that
I want to preserve parse order of elements from the org-mode file. I want to be
able to parse a file and then print it, and have the result be equivalent
to the original file. I'm basing it on the parse trees I've seen from Wikipedia
and from linguistics textbooks, where the structure of the parse is in the
internal nodes and the text is contained in the leaves. The goal is that if you
removed leaves from the tree in depth-first order, you'd get a rudimentary
org-mode file, without any good formatting.

So, I'm going to be more explicit in the names of the types in this module, only
because I'm expecting folx to interact with the ParseTree than the Storage.Tree.
I may be wrong: in that case, I'll change the other names to be more
descriptive.

> import Database.Zation.Storage (Tree)

For the first version of this, I'm only worrying about parsing the outline
structure and then keeping the rest of the text as leaves. I'm sure that this
type will get more complicated to accommodate more of the different kinds of
markup in org-mode.

/PARSER COMBINATORS/

The first feature I'm going to parse is the outline-mode stars that form the
document tree of an org-mode file. The format is: beginning of line + any number
of asterics + space + any amount of characters + end of line is a headline.

To make it easier for myself, I'm going to assume that each string that this
functions parses, that it's NOT multiline. I'm familiar with loading files in
line-by-line, so I'm going to start with that. I'd like to have some kind of
stream-based system, or single-pass, or something like those.

The return type is just a pair of strings, just because I want to have an
intermediate representation before loading it into the parse tree that I can
see. This might be the right type though?

> outline :: Parsec String st (Tree String)
> outline = do

The first thing we need in the do-notation is to parse out the "stars" of the
start of a headline in org-mode, followed by a space

>   stars <- many1 (char '*')
>   _ <- char ' '

Next, we parse the headline, which is any number of characters, followed by a
new line. There are quite a few org-mode features embedded in headlines that I'm
going to work on parsing later.

>   headline <- many $ noneOf ['\n']

Finally, we return our pair

>   return (Outline (length stars) [Text headline])

OK, now that we've written our outline parser, the body text parser (basically everything else) should be straightforward

> body :: Parsec String st (Tree String)
> body = do

Consume everything until you get to a star

>   t <- many $ noneOf ['*']
>   return $ Text t

> parseText :: Parsec String st (Tree String)
> parseText = foldr (Outline 0 [Text ""]) <$> try outline <|> body <?> "Failure"
