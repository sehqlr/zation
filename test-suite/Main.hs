-- Tasty makes it easy to test your code. It is a test framework that can
-- combine many different types of tests into one suite. See its website for
-- help: <http://documentup.com/feuerbach/tasty>.
import qualified Test.Tasty
-- Hspec is one of the providers for Tasty. It provides a nice syntax for
-- writing tests. Its website has more info: <https://hspec.github.io>.
import Test.Tasty.Hspec

import qualified Database.Zation.Parser as P
import Text.Parsec (parse)

main :: IO ()
main = do
    test <- testSpec "zation" spec
    Test.Tasty.defaultMain test

spec :: Spec
spec = parallel $ do
    it "outline returns a Outline, leaving off the body text" $ do
        parse P.outline "" "* NEWS\nso much news" `shouldBe` Right (P.Outline 1 "NEWS" [])
