# Optimised dateme function
switch (uname)
  case Darwin
    function dateme
      gdate $argv 
    end
  case '*'
    function dateme
      date $argv
    end
end
