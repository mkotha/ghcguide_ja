{- needs HaXml < 1.14 -}
module Main where

import Text.XML.HaXml.Types as Ha
import Text.XML.HaXml.Combinators
import Text.XML.HaXml.Verbatim
import Text.XML.HaXml.Parse
import Text.XML.HaXml.Pretty
import Text.PrettyPrint.HughesPJ(render)
import Data.List
import Data.Char

import XMLFormat as XF hiding(tag)
import qualified XMLFormat as XF

instance XF.Element Ha.Element where
  tag (Elem t _ _) = t
  attr (Elem _ a _) = map to_pair a
    where
      to_pair (n, a) = (n, av_to_s a)
      av_to_s (AttValue vs) = concatMap to_s vs
      to_s (Left s) = s
      to_s (Right r) = verbatim r
  content (Elem _ _ c) = map to_c c
    where
      to_c (CElem e) = Child e
      to_c (CString _ str) = Other str
      to_c (CRef ref) = Other (verbatim ref)
      to_c (CMisc misc) = error "unsupported misc"
  noEmpty (Elem t _ _) = t `notElem` ["link", "meta", "img", "object", "br", "hr"]
  isVerbatim (Elem t _ _) = t == "pre"

fmt :: Document -> String
fmt (Document pro _ e _) = spro ++ "\n" ++ main
  where
   spro = render $ prolog pro
   main = format $ removeUnneeded $ removeEmpty $ fixLang e

main = do
  s <- getContents
  putStr $ fmt $ xmlParse "input" s

applyToElement :: CFilter -> Ha.Element -> Ha.Element
applyToElement f e = case f (CElem e)  of
  [CElem e'] -> e'

fixLang :: Ha.Element -> Ha.Element
fixLang root = applyToElement (replaceAttrs [("lang", defLang), ("xml:lang", defLang), ("xmlns", "http://www.w3.org/1999/xhtml")]) root
  where
    defLang = case group $ sort $ filter (not . null) langs of
      [] -> "en"
      lss -> head $ maximumBy cmplen lss
      where
        langs = map fst $ attributed "lang" (multi keep) (CElem root)
        cmplen x y = compare (length x) (length y)

removeUnneeded :: Ha.Element -> Ha.Element
removeUnneeded = applyToElement (foldXml f)
  where
    f = (tag "div" `with` noattr /> keep) |>| keep
    noattr x@(CElem (Elem _ [] _)) = [x]
    noattr _ = []

removeEmpty :: Ha.Element -> Ha.Element
removeEmpty = applyToElement (foldXml f)
  where
    f = ((cat $ map tag ["p", "div", "pre", "ul", "dl", "ol"]) `without` (nonnull `o` children)) ?> none :> keep
    nonnull (CString _ s)
      | all isSpace s= []
    nonnull x = [x]

