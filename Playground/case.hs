-- case.hs

describeList:: [a] -> String
describeList list = "The list is "++ case list of [] -> "empty"
                                                  [a]-> "singleton"
                                                  list->"a normal list"