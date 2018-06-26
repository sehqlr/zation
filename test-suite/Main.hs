-- Tasty makes it easy to test your code. It is a test framework that can
-- combine many different types of tests into one suite. See its website for
-- help: <http://documentup.com/feuerbach/tasty>.
import qualified Test.Tasty
-- Hspec is one of the providers for Tasty. It provides a nice syntax for
-- writing tests. Its website has more info: <https://hspec.github.io>.
import Test.Tasty.Hspec
import qualified Parser
import Text.Parsec (parse)

main :: IO ()
main = do
    test <- testSpec "zation" spec
    Test.Tasty.defaultMain test

spec :: Spec
spec = parallel $ do
    it "a simple headline gets parsed by Parser.headline, leaving off the body text" $ do
        parse Parser.headline "" "* NEWS\nso much news" `shouldBe` Right ("*", "NEWS")