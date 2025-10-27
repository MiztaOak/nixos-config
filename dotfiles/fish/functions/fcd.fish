function fcd
     cd $(dirname $(fd --type file | fzf)); 
end
