module XMLFormat(format, ContentView(..), Element(..)) where

import Data.List(groupBy, findIndex)
import Data.Maybe(mapMaybe)
import Data.Char

import Debug.Trace

data ContentView element
  = Child element
  | Other String

class Element a where
  tag :: a -> String
  attr :: a -> [(String, String)]
  content :: a -> [ContentView a]
  noEmpty :: a -> Bool
  isVerbatim :: a -> Bool

as_str :: (Element a) => a -> String
as_str x = "(ELM " ++ tag x ++ show (attr x) ++ concatMap view_to_str (content x) ++ ") "

view_to_str :: (Element a) => ContentView a -> String
view_to_str (Child element) = "Child " ++ as_str element
view_to_str (Other s) = "Other " ++ show s

isText :: ContentView a -> Bool
isText (Child _) = False
isText _ = True

hasText :: (Element a) => a -> Bool
hasText = any isText . content

fromText :: ContentView a -> Maybe String
fromText (Other s) = Just s
fromText _ = Nothing

breakAndIndent :: String -> Bool
breakAndIndent ('\n':cs) = all isSpace cs
breakAndIndent _ = False

isLeaf :: (Element a) => a -> Bool
isLeaf = null . content

type SS = String -> String

(+++) :: SS -> SS -> SS
(+++) = (.)

lit :: String -> SS
lit = (++)

cmap :: (a -> SS) -> [ContentView a] -> SS
cmap f = foldr (+++) id . map ff
  where
    ff (Child e) = f e
    ff (Other str) = lit str

to_str = ($"")
format :: (Element a) => a -> String
format x = to_str $ fmt 0 x
  where
    fmt level x
      | isLeaf x = indent leaf
      | isVerbatim x = lit "\n" +++ complete_open +++ verbatim_content +++ close +++ lit "\n"
      | any isText cont = indent $ complete_open +++ inline_content +++ close
      | otherwise    = indent complete_open +++ lit "\n" +++ block_content +++ indent close
      where
        indent = (lit (replicate (2*level) ' ')+++)
        open = open_tag_open x
        complete_open = open_tag x
        close = close_tag x +++ lit "\n"

        verbatim_content = lit $ {- cut_indent $ -} to_str raw_content
        inline_content = lit $ {- remove_white $ -} to_str raw_content
        raw_content = cmap fmt_inline cont
        block_content = cmap (fmt (level + 1)) cont
        cont = remove_extra_space $ content x
        remove_extra_space cs
          | all (maybe True breakAndIndent . fromText) cs = filter (maybe True (not . breakAndIndent) . fromText) cs
          | otherwise = cs
        leaf
          | noEmpty x = complete_open +++ close
          | otherwise = open +++ lit " />\n"

    fmt_inline x
      | isLeaf x  = leaf
      | otherwise = complete_open +++ inline_content +++ close
      where
        open = open_tag_open x
        complete_open = open_tag x
        close = close_tag x
        inline_content = cmap fmt_inline (content x)
        leaf
          | noEmpty x = complete_open +++ close
          | otherwise = open +++ lit " />\n"

    open_tag_open x = lit $ safe_init $ ("<" ++ (tag x) ++ " ") ++ format_attr (attr x)
    open_tag x = open_tag_open x +++ lit ">"
    close_tag x = lit ("</" ++ tag x ++ ">")

    safe_init [] = []
    safe_init xs = init xs

cut_indent :: String -> String
cut_indent = init . unlines . fixTop . cut . fixBottom . lines
  where
    fixTop [] = []
    fixTop [first] = [first]
    fixTop (first:second:ls) = (first++second):ls
    fixBottom ls = reverse $ case reverse ls of
      [] -> []
      [last] -> [last]
      last:second:rest -> (second ++ dropWhile (==' ') last):rest
    cut [] = []
    cut (first:ls)
      | all empty ls = first:map (const "") ls
      | otherwise = first:map (drop depth) ls
      where
        depth = minimum $ mapMaybe prec ls
        prec = findIndex (/=' ')
    empty = all (==' ')

remove_white :: String -> String
remove_white = trim . concat . map newline_to_space . groupBy weq
  where
    weq x y = white x == white y
    newline_to_space s
      | elem '\n' s = " "
      | otherwise = s

drop_white = dropWhile white
trim = drop_white . reverse . drop_white . reverse

white ' ' = True
white '\n' = True
white _ = False

format_attr :: [(String, String)] -> String
format_attr = concatMap attr
  where
    attr (k, v) = k ++ "=\"" ++ v ++ "\" "

