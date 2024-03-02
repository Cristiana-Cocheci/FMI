module Html where

import           Control.Monad.Reader (Reader, ask, runReader)
import           Data.List            (intercalate)
import           Data.String
import           Prelude              hiding (div)
import           System.Environment   (getArgs)
import           System.IO            (writeFile)
{-
main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> do
      putStrLn "-- BUILD FAILED --"
      putStrLn "You must provide an email address as a command line argument."
    (email:_) -> do
      writeFile filePath . generateHtmlDocContent $ runReader view email
      putStrLn "-- BUILD SUCCESSFUL --"
      putStrLn $ "HTML generated and written to file \"" ++ filePath ++ "\"."
  where
    filePath = "reader-example.html"

view :: Reader Email Html
view = do
  page' <- page
  return $ div
      [ page'
      ]

page :: Reader Email Html
page = do
  content' <- content
  return $ div
    [ topNav
    , content'
    ]

topNav :: Html
topNav =
  div
    [ h1 [ "OurSite.com" ]
    ]

content :: Reader Email Html
content = do
  email <- ask
  right' <- right
  return $ div
    [ h3 [ "Custom Content for " ++ email ]
    , left
    , right'
    ]

left :: Html
left =
  div
    [ p [ "this is the left side" ]
    ]

right :: Reader Email Html
right = do
  article' <- article
  return $ div
    [ article'
    ]

article :: Reader Email Html
article = do
  widget' <- widget
  return $ div
    [ p [ "this is an article" ]
    , widget'
    ]

widget :: Reader Email Html
widget = do
  email <- ask
  return $ div
    [ p [ "Hey " ++ email ++ ", we've got a great offer for you!" ]
    ]
-}
type Html = String
type Email = String

combine :: [Html] -> Html
combine = intercalate ""

div :: [Html] -> Html
div children =
  "<div>" ++ combine children ++ "</div>"

h1 :: [Html] -> Html
h1 children =
  "<h1>" ++ combine children ++ "</h1>"

h3 :: [Html] -> Html
h3 children =
  "<h3>" ++ combine children ++ "</h3>"

p :: [Html] -> Html
p children =
  "<p>" ++ combine children ++ "</p>"

generateHtmlDocContent :: Html -> Html
generateHtmlDocContent html =
  "<!DOCTYPE html>\n\
    \<html lang=\"en\">\n\
    \\t<head>\n\
      \\t\t<meta charset=\"UTF-8\">\n\
      \\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n\
      \\t\t<meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n\
      \\t\t<title>Document</title>\n\
    \\t</head>\n\
    \\t<body>\n"
  ++ "\t\t" ++ html
  ++ "\n\t</body>\n\
    \</html>\n"